<h1 align='center'>Linux overview</h1>

<p align='center'>
    <img src="./assets/images/linux.png" width="450"  />
</p>

---

# 🐧 Introduction to Linux

## What is Linux?

Linux is **not just one thing** — and that’s where beginners get confused.

Linux can be understood as:
- **A kernel** (core of the OS)
- **An operating system** (kernel + tools + applications)
- **A development platform**
- **An open-source philosophy**

At its core:
> **Linux is an open-source operating system built around the Linux kernel.**

Linux runs:
- Servers 🌐
- Smartphones 📱 (Android)
- Smart TVs, routers, cars 🚗
- Cloud platforms ☁️
- Supercomputers 🚀

You already use Linux **every day**, even if you’ve never installed it.

---

## Why Linux Is Everywhere

Linux dominates because it is:
- Free (as in freedom)
- Stable
- Secure
- Modular
- Highly customizable

### Real-world usage
- **Android** → Linux-based  
- **Chrome OS** → Linux  
- **Amazon AWS, Google Cloud, Azure** → Linux servers  
- **Top 10 websites** → Linux-powered  
- **Dev tools** → Python, PHP, Ruby ship with Linux  

Most cloud and DevOps jobs **expect Linux knowledge** — period.

---

## A Quick History of Linux

### Unix (1960s)
- Created by AT&T
- Powerful, modular, stable
- But **commercial and restricted**

### GNU Project (1980s)
- Started by **Richard Stallman**
- Goal: create a **free Unix-like OS**
- Built:
  - Compilers
  - Libraries
  - Command-line tools  
- Missing piece: **Kernel**

### Linux Kernel (1991)
- Created by **Linus Torvalds**, a Finnish student
- Built a kernel to work with GNU tools
- Made it **open source**
- Community contributions exploded

👉 GNU tools + Linux kernel = **Linux OS**

(Technically called **GNU/Linux**, but everyone says *Linux*.)

---

## What is the Linux Kernel?

The **kernel** is the heart of the OS. It manages:
- CPU
- Memory
- Devices
- Processes
- File systems

Linux kernel responsibilities:
- Talks to hardware
- Enforces security
- Manages system resources

Everything else runs **on top of the kernel**.

---

## What is a Linux Distribution (Distro)?

A **Linux distribution** is:
> Linux Kernel + system tools + package manager + applications

Examples:
- Ubuntu
- Fedora
- Debian
- Red Hat Enterprise Linux (RHEL)
- Arch Linux

Think of it like:
> Same engine, different car designs 🚗

---

## Major Linux Distribution Families

### 1️⃣ Debian-based
- Stable
- Community-driven
- Uses **APT** package manager

Examples:
- Debian
- Ubuntu
- Linux Mint
- Kali Linux

Best for:
- Beginners
- Servers
- Developers

---

### 2️⃣ Red Hat–based
- Enterprise-focused
- Uses **RPM / DNF**

Examples:
- Red Hat Enterprise Linux (RHEL)
- Fedora
- Rocky Linux
- AlmaLinux

Best for:
- Corporate servers
- DevOps & Cloud jobs

---

### 3️⃣ Arch-based
- Lightweight
- Rolling release
- Advanced users

Examples:
- Arch Linux
- Manjaro
- EndeavourOS

Best for:
- Learning internals
- Power users

---

### 4️⃣ Slackware-based
- Oldest distro
- Manual configuration
- Advanced users only

---

## Open Source Explained (Important for Exams)

### Free ≠ Free Cost

“Free” means:
- Free to use
- Free to modify
- Free to distribute

Not necessarily free money-wise.

### Open Source vs Closed Source

| Open Source | Closed Source |
|------------|--------------|
| Source code visible | Source code hidden |
| Community-driven | Company-controlled |
| Can modify | Cannot modify |

---

## GNU General Public License (GPL)

GPL rules:
- You can sell GPL software
- You can modify it
- You can distribute it
- If you release changes → source code must be shared
- **Once GPL, always GPL**

⚠️ Copy GPL code into closed software → whole project becomes open source.

---

## Enterprise Linux Ecosystem (Reality Check)

### Fedora → CentOS Stream → RHEL

- **Fedora**: Experimental, latest features
- **CentOS Stream**: Preview of next RHEL
- **RHEL**: Stable, enterprise-grade

### CentOS Situation
- Old CentOS Linux → discontinued (2021)
- Replacements:
  - **Rocky Linux**
  - **AlmaLinux**

Both are:
- Free
- RHEL-compatible
- Production-ready

---

## What is Virtualization?

Virtualization means:
> Running fake (virtual) hardware using software

Instead of:
- Buying physical servers ❌

You use:
- Virtual Machines (VMs) ✅

---

## Hypervisor

A **hypervisor** manages virtual machines.

### Type 2 Hypervisor (Used for learning)
- Runs on host OS

Example:
- VirtualBox
- VMware Workstation

Flow:
```
VM → Guest OS → Hypervisor → Host OS → Hardware
```

VirtualBox provides:
- Virtual CPU
- Virtual RAM
- Virtual Disk
- Virtual Network
- Virtual BIOS

Perfect for:
- Linux practice
- Server labs
- Networking experiments

---

## Why Linux + Virtualization is Powerful

- No cost
- No risk
- Easy rollback
- Real server experience
- Cloud-ready skills

This combo is **non-negotiable** for:
- DevOps
- Cloud Engineer
- System Admin
- Cybersecurity

---
<br><br>


# 📌 Core Linux Topics 

## 1️⃣ Linux File System

Linux uses a **single-root directory structure** starting at `/`.

### Important directories
- `/` → Root of everything  
- `/home` → User personal files  
- `/etc` → Configuration files  
- `/var` → Logs, mail, variable data  
- `/bin` → Essential user commands  
- `/sbin` → System/admin commands  
- `/usr` → Applications and libraries  
- `/tmp` → Temporary files  

📌 **Rule**: Everything in Linux is treated as a file.

---

## 2️⃣ Basic Linux Commands

Used to navigate and manage files.

### Common commands
- `pwd` → Show current directory  
- `ls` → List files  
- `cd` → Change directory  
- `mkdir` → Create directory  
- `rm` → Delete files/directories  
- `cp` → Copy files  
- `mv` → Move/rename files  
- `cat` → View file content  
- `clear` → Clear terminal  

📌 Commands are **case-sensitive**.

---

## 3️⃣ Users & Permissions

Linux is a **multi-user operating system**.

### User types
- **Root** → Superuser (full access)
- **Normal users** → Limited access
- **System users** → Run services

### Permissions
- `r` → Read  
- `w` → Write  
- `x` → Execute  

Format:
```bash
-rwxr-xr--
```
Owner | Group | Others

### Key commands
- `chmod` → Change permissions  
- `chown` → Change ownership  

📌 Permissions protect the system from misuse.

---

## 4️⃣ Package Management

Used to install, update, and remove software.

### Debian-based (Ubuntu)
- `apt install package`
- `apt remove package`
- `apt update`

### Red Hat–based (RHEL, Fedora)
- `dnf install package`
- `dnf remove package`
- `dnf update`

📌 No random downloads — package manager handles dependencies.

---

## 5️⃣ Services & systemd

Services are **background programs** (daemons).

Examples:
- web server
- database
- ssh

### systemctl commands
- `systemctl start service`
- `systemctl stop service`
- `systemctl restart service`
- `systemctl status service`
- `systemctl enable service`

📌 `systemd` controls system startup and services.

---

## 6️⃣ Shell Scripting

Shell scripting is **automation using commands**.

### Why use it?
- Automate tasks
- Reduce manual work
- Essential for DevOps

### Example script
```bash
#!/bin/bash
echo "Hello Linux"
```

Run with:
```bash
bash script.sh
```
📌 Shell scripts save time and prevent human errors.



<br><br>

[Click here to redirect to INDEX](../README.md) 