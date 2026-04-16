#  Azure PowerShell Inventory Automation

##  Project Overview
This project is an enterprise-level PowerShell automation solution designed to collect system inventory from both standalone systems and Active Directory domain environments.

It helps IT teams automate asset discovery, monitoring, and reporting across infrastructure.

---

##  Problem Statement
In enterprise environments, manual tracking of system details is time-consuming and error-prone.

This solution automates:
- System discovery
- Hardware & OS inventory
- Network details collection
- Domain-wide reporting

---

##  Features
-  Connectivity check (Online/Offline)
-  OS & system details
-  CSV reporting
-  Hardware inventory (CPU, RAM, Disk)
-  Network details (IP, MAC)
-  Domain vs Workgroup detection
-  Active Directory bulk inventory

---

##  Project Structure
Scripts are built in progressive levels:

| Script | Purpose |
|--------|--------|
| 01 | Basic connectivity check |
| 02 | OS information |
| 03 | Export to CSV |
| 04 | Basic inventory |
| 05 | Advanced inventory |
| 06 | Domain-wide inventory |

---

##  Enterprise Use Case
- IT Asset Management  
- Infrastructure Monitoring  
- Audit & Compliance Reporting  
- Server & Client Inventory Tracking  

---

##  Prerequisites
- PowerShell 5.1+
- Administrator access
- WinRM enabled on target systems
- Network connectivity (including VLAN routing)
- Active Directory module (for domain script)

---

##  Limitations
- Requires proper permissions
- Depends on WinRM configuration
- Systems behind restricted firewalls may not respond
## ⚠️ Troubleshooting

### 1. Script not running (Execution Policy Error)

**Error:**
File cannot be loaded because running scripts is disabled on this system.

**Solution (Temporary - Recommended for testing):**
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

---

##  How to Run

### Local Inventory
```powershell
.\05-advanced-inventory.ps1

