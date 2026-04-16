$computer = "localhost"

Write-Host "Checking system: $computer"

if (Test-Connection -ComputerName $computer -Count 1 -Quiet) {
    Write-Host "Status: ONLINE"

    $os = Get-CimInstance Win32_OperatingSystem

    Write-Host "OS Name: $($os.Caption)"
    Write-Host "Version: $($os.Version)"
    Write-Host "Architecture: $($os.OSArchitecture)"
}
else {
    Write-Host "Status: OFFLINE"
}
