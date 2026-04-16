# 🚀 Azure PowerShell Inventory Automation

## 📌 Project Overview

This project is an enterprise-grade PowerShell automation solution designed to collect system inventory across standalone (workgroup) systems and Active Directory (domain) environments.

It provides centralized visibility into infrastructure by automating asset discovery, monitoring, and reporting, reducing manual effort and improving operational efficiency.

---

## 🎯 Problem Statement

In enterprise environments:

* System inventory is often maintained manually
* Data becomes inconsistent and outdated
* Lack of centralized visibility across networks

This leads to:

* Inefficient asset management
* Increased security risks
* Compliance and audit challenges

---

## 💡 Solution

This solution automates:

* System discovery across environments
* Hardware and OS inventory collection
* Network information (IP, MAC) gathering
* Domain-wide system reporting
* CSV/HTML reporting for audit and tracking

---

## ⚙️ Features

* ✔ Connectivity check (Online/Offline)
* ✔ OS and system information
* ✔ Hardware inventory (CPU, RAM, Disk)
* ✔ Network details (IP Address, MAC Address)
* ✔ Domain vs Workgroup detection
* ✔ Device type identification (Laptop/Desktop)
* ✔ Manufacturer and model details
* ✔ Multi-system/domain inventory
* ✔ CSV and HTML report generation
* ✔ Logging and retry mechanism
* ✔ Parallel execution for performance
* ✔ Parameter-based reusable tool

---

## 🧩 Project Structure (Development Approach)

| Version | Script                      | Description                              |
| ------- | --------------------------- | ---------------------------------------- |
| V1      | 01-basic-connectivity.ps1   | System connectivity check                |
| V2      | 02-os-info.ps1              | OS information retrieval                 |
| V3      | 03-csv-export.ps1           | Export data to CSV                       |
| V4      | 04-inventory-basic.ps1      | Basic system inventory                   |
| V5      | 05-advanced-inventory.ps1   | Full hardware inventory                  |
| V6      | 06-domain-inventory.ps1     | Domain-based inventory                   |
| V7      | 07-enterprise-inventory.ps1 | Enterprise tool with automation features |

---

## 🏢 Enterprise Use Cases

* IT Asset Management
* Infrastructure Monitoring
* Audit & Compliance Reporting
* Server and Client Inventory Tracking
* Pre-migration Infrastructure Assessment

---

## 🛠️ Technologies & Tools

* PowerShell 5.1+
* CIM / WMI (Get-CimInstance)
* Active Directory Module
* WinRM (Remote Management)
* Git & GitHub

---

## ▶️ How to Run

### 🔹 Local Inventory

```powershell
.\07-enterprise-inventory.ps1
```

### 🔹 Multiple Systems

```powershell
.\07-enterprise-inventory.ps1 -InputFile computers.txt
```

### 🔹 Domain Environment

```powershell
.\07-enterprise-inventory.ps1 -UseCredential
```

---

## ⚠️ Troubleshooting & Challenges

### 🔴 Execution Policy Issue

**Error:**
Running scripts is disabled

**Fix:**

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

---

### 🔴 Git Push Rejected

**Error:**
Remote contains changes not present locally

**Fix:**

```bash
git pull --rebase origin main
git push
```

---

### 🔴 Incorrect Git Directory

**Issue:**
Repository initialized in wrong location

**Fix:**

```bash
cd /c/PowerShell-Inventory-Automation/Scripts
git init
```

---

### 🔴 WinRM Not Configured

**Issue:**
Remote systems not accessible

**Fix:**

```powershell
winrm quickconfig
Enable-PSRemoting -Force
```

---

### 🔴 Firewall Blocking WinRM

**Issue:**
Public network blocking remote access

**Fix:**

* Change network profile to Private or Domain
* Allow WinRM ports (5985/5986)

---

### 🔴 CIM Session Access Denied

**Issue:**

```text
New-CimSession : Access is denied
```

**Root Cause:**
Using remote session for local system

**Fix:**

* Local system → direct Get-CimInstance
* Remote system → CIM session with credentials

---

### 🔴 Credential Handling Issue

**Issue:**
Script failed due to mandatory credential prompt

**Fix:**

* Made credential optional using parameter:

```powershell
-UseCredential
```

---

## 📚 Key Learnings

* Local vs Remote execution in PowerShell
* WinRM configuration in enterprise environments
* Handling firewall and permission issues
* Writing reusable and scalable automation scripts
* Converting scripts into production-ready tools
* Version control using GitHub

---

## 🚀 Final Outcome

A production-ready automation tool capable of:

* Local system inventory
* Workgroup environment support
* Domain-wide inventory collection
* Parallel execution for faster processing
* CSV and HTML reporting
* Logging and retry handling

---

## ⚠️ Limitations

* Requires appropriate permissions
* Dependent on WinRM configuration for remote systems
* Firewall restrictions may block access
* Offline systems will not respond

---

## 🔮 Future Enhancements

* Task Scheduler automation
* Email alerting system
* Power BI dashboard integration
* Azure VM inventory integration

---

## 👨‍💻 Author

**Sachin Kumar**
Azure & Windows Infrastructure Engineer
Delhi NCR, India

---

## ⭐ Support

If you found this project useful:

* Star the repository
* Share with others
* Use it in your portfolio
