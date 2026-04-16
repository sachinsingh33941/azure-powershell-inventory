$computer = "localhost"

if (Test-Connection -ComputerName $computer -Count 1 -Quiet) {

    $os = Get-CimInstance Win32_OperatingSystem

    $result = [PSCustomObject]@{
        ComputerName = $computer
        Status = "Online"
        OSName = $os.Caption
        Version = $os.Version
        Architecture = $os.OSArchitecture
    }

    $result | Export-Csv "SystemReport.csv" -NoTypeInformation
}
