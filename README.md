# Azure PowerShell Inventory Automation

## Project Overview
This project is an enterprise-grade PowerShell automation solution designed to collect system inventory from both standalone (workgroup) systems and Active Directory (domain) environments.

It helps IT teams automate asset discovery, monitoring, and reporting across infrastructure.

---

## Problem Statement
In enterprise environments:

- System inventory is often tracked manually
- Data is inconsistent and outdated
- No centralized visibility across networks

This leads to:
- Poor asset management
- Security risks
- Compliance issues

---

## Solution
This project automates:

- System discovery
- Hardware & OS inventory
- Network information collection
- Domain-wide reporting
- CSV-based reporting for audits

---

## Features

- Connectivity check (Online/Offline)
- OS & system details
- CSV reporting
- Hardware inventory (CPU, RAM, Disk)
- Network details (IP, MAC)
- Domain vs Workgroup detection
- Device type detection (Laptop/Desktop)
- Manufacturer & Model info
- Domain-wide inventory collection

---

## Project Structure

Scripts are built in progressive levels:

| Script | Description |
|--------|------------|
| 01-basic-connectivity.ps1 | Check system status |
| 02-os-info.ps1 | Fetch OS information |
| 03-csv-export.ps1 | Export data to CSV |
| 04-inventory-basic.ps1 | Basic inventory details |
| 05-advanced-inventory.ps1 | Full system inventory |
| 06-domain-inventory.ps1 | Domain-wide inventory |

---

## Enterprise Use Cases

- IT Asset Management
- Infrastructure Monitoring
- Audit & Compliance Reporting
- Server & Client Inventory Tracking
- Pre-migration assessment

---

## Prerequisites

- PowerShell 5.1 or above
- Administrator access
- WinRM enabled on target systems
- Network connectivity (including VLAN routing)
- Active Directory module (for domain script)

---

## How to Run

### Run Local Inventory
powershell
.\05-advanced-inventory.ps1

### Run Domain Inventory
powershell
.\06-domain-inventory.ps1

---

## Troubleshooting

### Execution Policy Issue
powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned

### Enable Remote Access
powershell
Enable-PSRemoting -Force

### Required Permissions
- Domain user or admin access
- Remote WMI/WinRM access

### Network Requirements
- VLAN routing enabled
- Firewall allows WinRM (5985/5986)
- Systems reachable via hostname/IP

---

## Limitations

- Requires proper permissions
- Depends on WinRM configuration
- Firewall restrictions may block access
- Offline systems will not respond

---

## Learning Outcomes

- PowerShell automation
- Infrastructure monitoring
- Active Directory integration
- Enterprise scripting practices

---

## Future Enhancements

- Task Scheduler automation
- Power BI dashboard integration
- Azure VM inventory
- Email alerting system

---

## Author

Sachin Kumar  
Azure & Windows Infrastructure Engineer  
Delhi NCR, India  

---

## Support

If you found this project useful:

- Star the repository
- Share with others
- Use it in your portfolio
📌 🔥 ADD THIS TO YOUR README (COPY-PASTE)
🧩 Development Sequence

This project was built in a structured, step-by-step approach to simulate real-world learning and enterprise implementation.

Version	Script	Description
V1	01-basic-connectivity.ps1	Checked system availability using ping
V2	02-os-info.ps1	Retrieved OS details (Name, Version, Architecture)
V3	03-csv-export.ps1	Exported system details into CSV format
V4	04-inventory-basic.ps1	Added hostname, IP, MAC, domain/workgroup detection
V5	05-advanced-inventory.ps1	Collected full hardware inventory (CPU, RAM, Disk, BIOS)
V6	06-domain-inventory.ps1	Enabled multi-system inventory using remote execution
V7	main-inventory.ps1	Final enterprise tool with parameters, logging, retry, HTML report, and parallel execution
⚠️ Troubleshooting & Challenges Faced

During development, several real-world infrastructure issues were encountered and resolved:

🔴 1. PowerShell Execution Policy Error

Issue:

running scripts is disabled on this system

Solution:

Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
🔴 2. Git Push Rejected Error

Issue:

updates were rejected because the remote contains work that you do not have locally

Solution:

git pull --rebase origin main
git push
🔴 3. Wrong Git Directory Issue

Issue:
Git was initialized in the wrong directory (C:\Users\Admin)

Solution:

cd /c/PowerShell-Inventory-Automation/Scripts
git init
🔴 4. WinRM Not Configured

Issue:
Remote systems were not reachable

Solution:

winrm quickconfig
Enable-PSRemoting -Force
🔴 5. Firewall Blocking WinRM (Public Network)

Issue:

WinRM firewall exception will not work since network type is Public

Solution:

Changed network profile to Private
Enabled firewall rule
🔴 6. CIM Session Access Denied

Issue:

New-CimSession : Access is denied

Root Cause:

Using remote session for local system

Solution:

Local system → direct Get-CimInstance
Remote system → use New-CimSession with credential
🔴 7. Credential Prompt Issues

Issue:
Script failed when credential was mandatory

Solution:

Made credential optional using parameter:
-UseCredential
✅ Key Learnings
Difference between local and remote execution in PowerShell
Importance of WinRM in enterprise environments
Handling permissions and firewall issues
Writing reusable and scalable scripts
Converting scripts into real automation tools
Using GitHub for version control and project tracking
🚀 Final Outcome

A production-ready PowerShell automation tool capable of:

Local system inventory
Workgroup environment support
Active Directory domain-wide inventory
Parallel execution for performance
CSV and HTML reporting
Logging and retry mechanisms
