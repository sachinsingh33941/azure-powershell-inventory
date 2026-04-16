
$computer = "localhost"

if (Test-Connection -ComputerName $computer -Count 1 -Quiet) {

    # Get hostname
    $hostname = hostname

    # Get OS info
    $os = Get-CimInstance Win32_OperatingSystem

    # Get network info (IP + MAC)
    $network = Get-CimInstance Win32_NetworkAdapterConfiguration |
               Where-Object { $_.IPEnabled -eq $true }

    # Get first IP and MAC
    $ip = $network.IPAddress[0]
    $mac = $network.MACAddress

    # Check domain or workgroup
    $cs = Get-CimInstance Win32_ComputerSystem
    $domain = $cs.Domain
    $role = $cs.PartOfDomain

    if ($role -eq $true) {
        $environment = "Domain"
    } else {
        $environment = "Workgroup"
    }

    # Create object
    $result = [PSCustomObject]@{
        ComputerName = $computer
        Hostname     = $hostname
        Status       = "Online"
        Environment  = $environment
        Domain       = $domain
        OSName       = $os.Caption
        Version      = $os.Version
        Architecture = $os.OSArchitecture
        IPAddress    = $ip
        MACAddress   = $mac
    }

    # Export report
    $result | Export-Csv "SystemInventoryReport.csv" -NoTypeInformation
}
else {
    Write-Host "$computer is OFFLINE"
}