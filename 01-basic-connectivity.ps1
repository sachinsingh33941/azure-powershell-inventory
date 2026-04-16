<$computer = "localhost"

if (Test-Connection -ComputerName $computer -Count 1 -Quiet) {
    Write-Host "$computer is ONLINE"
} else {
    Write-Host "$computer is OFFLINE"
}