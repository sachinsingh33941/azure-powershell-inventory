# Azure PowerShell Inventory Automation

##  Overview
This project provides PowerShell-based automation scripts to collect system inventory from local machines and Active Directory domain environments.

## Features
- Connectivity check (Online/Offline systems)
- OS information collection
- CSV report generation
- Full system inventory (CPU, RAM, Disk, BIOS)
- Network details (IP, MAC)
- Domain vs Workgroup detection
- Active Directory bulk inventory

## Scripts
| Script | Description |
|--------|------------|
| 01-basic-connectivity.ps1 | Checks if system is online |
| 02-os-info.ps1 | Fetch OS details |
| 03-csv-export.ps1 | Export system data to CSV |
| 04-inventory-basic.ps1 | Basic inventory collection |
| 05-advanced-inventory.ps1 | Detailed system inventory |
| 06-domain-inventory.ps1 | Collect inventory from all domain systems |

## Prerequisites
- PowerShell 5.1+
- Admin privileges
- WinRM enabled on remote systems
- Network connectivity between systems

##  Real-world Use Case
- Enterprise IT asset management
- Infrastructure monitoring
- Audit & compliance reporting

##  Requirements for Domain Script
- WinRM enabled (`Enable-PSRemoting`)
- Firewall ports open (5985/5986)
- Domain Admin or required permissions
- AD module installed

## Output
- CSV-based reports for all systems

## Author
Sachin Kumar  
Azure & Infrastructure Engineer
## ⚠️ Troubleshooting

### 1. Script not running (Execution Policy Error)

**Error:**
File cannot be loaded because running scripts is disabled on this system.

**Solution (Temporary - Recommended for testing):**
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
Solution (Permanent - User Level):
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned


