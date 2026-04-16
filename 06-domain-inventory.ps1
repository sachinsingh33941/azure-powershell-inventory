
$results = foreach ($computer in $computers) {

    Write-Host "Processing $computer..."

    try {
        if (Test-Connection -ComputerName $computer -Count 1 -Quiet) {

            $os = Get-CimInstance Win32_OperatingSystem -ComputerName $computer
            $cs = Get-CimInstance Win32_ComputerSystem -ComputerName $computer
            $cpu = Get-CimInstance Win32_Processor -ComputerName $computer
            $bios = Get-CimInstance Win32_BIOS -ComputerName $computer
            $disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'" -ComputerName $computer
            $net = Get-CimInstance Win32_NetworkAdapterConfiguration -ComputerName $computer |
                   Where-Object {$_.IPEnabled -eq $true}

            [PSCustomObject]@{
                ComputerName = $computer
                Status       = "Online"
                Domain       = $cs.Domain

                Manufacturer = $cs.Manufacturer
                Model        = $cs.Model

                OS           = $os.Caption
                Version      = $os.Version

                CPU          = $cpu.Name
                RAM_GB       = [math]::Round($cs.TotalPhysicalMemory / 1GB,2)

                Disk_Free_GB = [math]::Round($disk.FreeSpace / 1GB,2)

                IPAddress    = $net.IPAddress[0]
                MACAddress   = $net.MACAddress

                BIOSSerial   = $bios.SerialNumber
            }
        }
        else {
            [PSCustomObject]@{
                ComputerName = $computer
                Status       = "Offline"
            }
        }
    }
    catch {
        [PSCustomObject]@{
            ComputerName = $computer
            Status       = "Error"
        }
    }
}

$results | Export-Csv "AD_Inventory_Report.csv" -NoTypeInformation