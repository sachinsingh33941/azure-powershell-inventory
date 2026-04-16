<#
.SYNOPSIS
Enterprise Inventory Tool (Local + Domain + Workgroup Safe)

.AUTHOR
Sachin Kumar
#>

param(
    [string]$InputFile = "",
    [string]$OutputCSV = "Inventory.csv",
    [string]$OutputHTML = "Inventory.html",
    [int]$ThrottleLimit = 5,
    [switch]$UseCredential
)

# ================================
# CONFIG
# ================================
$LogFile = "inventory.log"
$RetryCount = 2

# Ask credential ONLY if needed
if ($UseCredential) {
    $Credential = Get-Credential
}

# ================================
# LOG FUNCTION
# ================================
function Write-Log {
    param ($Message, $Level = "INFO")
    $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$time [$Level] $Message" | Out-File -Append $LogFile
}

# ================================
# GET COMPUTERS
# ================================
if ($InputFile -ne "") {
    $computers = Get-Content $InputFile
}
else {
    try {
        Import-Module ActiveDirectory -ErrorAction Stop
        $computers = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name
    }
    catch {
        Write-Log "AD not available, using localhost" "WARN"
        $computers = @("localhost")
    }
}

Write-Host "Starting Inventory..."
Write-Host "Total Systems: $($computers.Count)"

# ================================
# FUNCTION
# ================================
function Get-SystemInfo {
    param ($ComputerName)

    for ($i = 1; $i -le $RetryCount; $i++) {

        try {

            if (-not (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet)) {
                return [PSCustomObject]@{
                    ComputerName = $ComputerName
                    Status       = "Offline"
                }
            }

            # ================================
            # LOCAL SYSTEM (NO REMOTING)
            # ================================
            if ($ComputerName -eq "localhost" -or $ComputerName -eq $env:COMPUTERNAME) {

                $os = Get-CimInstance Win32_OperatingSystem
                $cs = Get-CimInstance Win32_ComputerSystem
                $cpu = Get-CimInstance Win32_Processor
                $bios = Get-CimInstance Win32_BIOS
                $disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
                $net = Get-CimInstance Win32_NetworkAdapterConfiguration | Where-Object {$_.IPEnabled}

            }
            else {
                # ================================
                # REMOTE SYSTEM
                # ================================
                if ($UseCredential) {
                    $session = New-CimSession -ComputerName $ComputerName -Credential $Credential
                }
                else {
                    $session = New-CimSession -ComputerName $ComputerName
                }

                $os = Get-CimInstance Win32_OperatingSystem -CimSession $session
                $cs = Get-CimInstance Win32_ComputerSystem -CimSession $session
                $cpu = Get-CimInstance Win32_Processor -CimSession $session
                $bios = Get-CimInstance Win32_BIOS -CimSession $session
                $disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'" -CimSession $session
                $net = Get-CimInstance Win32_NetworkAdapterConfiguration -CimSession $session | Where-Object {$_.IPEnabled}

                Remove-CimSession $session
            }

            # Device Type
            $chassis = (Get-CimInstance Win32_SystemEnclosure).ChassisTypes
            if ($chassis -contains 8 -or $chassis -contains 9 -or $chassis -contains 10 -or $chassis -contains 14) {
                $deviceType = "Laptop"
            } else {
                $deviceType = "Desktop"
            }

            return [PSCustomObject]@{
                ComputerName = $ComputerName
                Status       = "Online"
                Domain       = $cs.Domain
                DeviceType   = $deviceType
                Manufacturer = $cs.Manufacturer
                Model        = $cs.Model
                OS           = $os.Caption
                CPU          = $cpu.Name
                RAM_GB       = [math]::Round($cs.TotalPhysicalMemory / 1GB,2)
                Disk_Free_GB = [math]::Round($disk.FreeSpace / 1GB,2)
                IPAddress    = $net.IPAddress[0]
                MACAddress   = $net.MACAddress
                BIOSSerial   = $bios.SerialNumber
            }

        }
        catch {
            if ($i -eq $RetryCount) {
                Write-Log "Error on $ComputerName" "ERROR"
                return [PSCustomObject]@{
                    ComputerName = $ComputerName
                    Status       = "Error"
                }
            }
        }
    }
}

# ================================
# EXECUTION (AUTO MODE)
# ================================
if ($computers.Count -eq 1) {
    Write-Host "Running in Sequential Mode..."
    $results = foreach ($c in $computers) {
        Write-Host "Processing $c..."
        Get-SystemInfo -ComputerName $c
    }
}
else {
    Write-Host "Running in Parallel Mode..."
    $results = $computers | ForEach-Object -Parallel {
        Get-SystemInfo -ComputerName $_
    } -ThrottleLimit $ThrottleLimit
}

# ================================
# EXPORT
# ================================
$results | Export-Csv $OutputCSV -NoTypeInformation

# HTML
$style = @"
<style>
table {border-collapse: collapse; width: 100%;}
th, td {border: 1px solid black; padding: 8px;}
th {background-color: #4CAF50; color: white;}
</style>
"@

$results | ConvertTo-Html -Head $style -Title "Inventory Report" | Out-File $OutputHTML

# ================================
# SUMMARY
# ================================
$summary = [PSCustomObject]@{
    Total   = $results.Count
    Online  = ($results | Where-Object {$_.Status -eq "Online"}).Count
    Offline = ($results | Where-Object {$_.Status -eq "Offline"}).Count
    Error   = ($results | Where-Object {$_.Status -eq "Error"}).Count
}

Write-Host "`n===== SUMMARY ====="
$summary | Format-Table

Write-Host "`n✅ Completed"
Write-Host "📄 CSV: $OutputCSV"
Write-Host "🌐 HTML: $OutputHTML"
Write-Host "📝 Log: $LogFile"
