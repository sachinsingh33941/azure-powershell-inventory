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
