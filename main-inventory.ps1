Write-Host "1. Check Single System"
Write-Host "2. Full Local Inventory"
Write-Host "3. Domain Inventory"

$choice = Read-Host "Select option"

switch ($choice) {
    1 { .\01-basic-connectivity.ps1 }
    2 { .\05-advanced-inventory.ps1 }
    3 { .\06-domain-inventory.ps1 }
}