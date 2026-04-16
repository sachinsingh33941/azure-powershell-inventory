$computer = "localhost"

Write-Host "Checking system: $computer"

# Step 1: Check connectivity
if (Test-Connection -ComputerName $computer -Count 1 -Quiet) {

    # Step 2: System Information
    $os = Get-CimInstance Win32_OperatingSystem
    $cs = Get-CimInstance Win32_ComputerSystem
    $bios = Get-CimInstance Win32_BIOS
    $cpu = Get-CimInstance Win32_Processor
    $disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"

    # Step 3: Network Information
    $ip = (Get-NetIPAddress -AddressFamily IPv4 |
           Where-Object {$_.IPAddress -notlike "169.*"} |
           Select-Object -First 1).IPAddress

    $mac = (Get-NetAdapter |
            Where-Object {$_.Status -eq "Up"} |
            Select-Object -First 1).MacAddress

    # Step 4: Domain or Workgroup detection
    $domain = $cs.Domain

    if ($cs.PartOfDomain) {
        $networkType = "Domain"
    } else {
        $networkType = "Workgroup"
    }

    # Step 5: Device Type (Laptop/Desktop guess)
    $chassis = (Get-CimInstance Win32_SystemEnclosure).ChassisTypes

    if ($chassis -contains 8 -or $chassis -contains 9 -or $chassis -contains 10 -or $chassis -contains 14) {
        $deviceType = "Laptop"
    } else {
        $deviceType = "Desktop"
    }

    # Step 6: RAM (GB)
    $ramGB = [math]::round($cs.TotalPhysicalMemory / 1GB, 2)

    # Step 7: CPU name (i3/i5/i7 etc comes in name)
    $processor = $cpu.Name

    # Step 8: Disk size
    $diskSizeGB = [math]::round($disk.Size / 1GB, 2)

    # Step 9: Create Object
    $result = [PSCustomObject]@{
        Hostname       = $env:COMPUTERNAME
        NetworkType    = $networkType
        Domain         = $domain
        IPAddress      = $ip
        MACAddress     = $mac
        DeviceType     = $deviceType
        Manufacturer   = $cs.Manufacturer
        Model          = $cs.Model
        BIOSVersion    = $bios.SMBIOSBIOSVersion
        RAM_GB         = $ramGB
        Processor      = $processor
        Disk_C_GB      = $diskSizeGB
        OS             = $os.Caption
        OSVersion      = $os.Version
    }

    # Step 10: Export report
    $result | Export-Csv "SystemInventoryReport.csv" -NoTypeInformation

    Write-Host "Report generated successfully"

}
else {
    Write-Host "System is OFFLINE"
}
