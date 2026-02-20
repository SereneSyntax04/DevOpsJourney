# PART1: A reference file for important and frequently used commands.

---

## Basic linux command (folder structure)

1. apt update <br>
`apt update` refreshes the package index so the system knows about the latest available software versions from repositories. 
- later for example to install new package you can use: `apt install python/other-package` 

<br>

2. root@ubuntu-dev:/#  <br>
- `root` → the current logged-in user (root = superuser); on EC2 you may see `ubuntu`, which is a non-root default user  
- `ubuntu-dev` → the hostname of the system  
- `:` → separator between hostname and directory  
- `/` → current working directory (pwd), here it means the root directory  
- `#` → indicates the shell is running as the root user (has full administrative privileges)

Example: shrushti@ubuntu-dev:~$  
- `shrushti` → the current logged-in user (non-root user)  
- `ubuntu-dev` → the hostname of the system  
- `:` → separator between hostname and directory  
- `~` → the user’s home directory (e.g., /home/ubuntu)  
- `$` → indicates the shell is running as a normal user (non-root, limited privileges)

<br>

3. ls -ltr  
- `ls` → lists files and directories  
- `-l` → displays in long listing format (permissions, owner, size, date, name)  
- `-t` → sorts files by modification time (newest first)  
- `-r` → reverses the order (oldest first)

```
Example Output: ls -ltr  
total 8
-rw-r--r-- 1 ubuntu ubuntu  120 Feb 18 10:12 file1.txt
-rw-r--r-- 1 ubuntu ubuntu  256 Feb 18 11:45 notes.md
drwxr-xr-x 2 ubuntu ubuntu 4096 Feb 19 09:30 logs/

Format explanation:
- `-rw-r--r--` → file permissions (read,write,execute)  
- `1` → number of links  
- `ubuntu` → owner  
- `ubuntu` → group  
- `120` → file size (in bytes)  
- `Feb 18 10:12` → last modification date & time  
- `file1.txt` → file name  

(Oldest files appear at the top, newest at the bottom due to `-ltr`)
```

<br>

[More explanation on System Directories](https://github.com/iam-veeramalla/ultimate-linux-guide/blob/main/02-folder-structure/README.md)

4. ls /

- `ls` → lists files and directories 

- `/sbin` → system binaries directory containing essential administrative and system management commands (mainly used by the root user)
- `adduser xyz` → creates a new user account named `xyz`; the `adduser` binary is typically located in `/usr/sbin` (system administration binaries)
(to view all users: ls /home command is used.)

- `ls /bin` → lists essential user command binaries (basic commands required for system operation, e.g., ls, cp, mv, cat)

- `ls /lib` → lists shared libraries needed by system binaries and applications to run (core system libraries)

- `ls /usr` → lists user system resources directory containing applications, libraries, and documentation (e.g., /usr/bin, /usr/lib, /usr/share)

- `ls /etc` → lists system-wide configuration files and directories used to control system and application settings (similar to windows: `c:/`) , 

---
<br>

## User Management  (Important for accountability and keeping linux environment secure.)

`sudo <command>` → run a command with superuser (root) privileges  

1. `useradd <username>` → creates a new user account 
- adduser or useradd both commands can be used to create an user.
remember, **useradd** won't create home directory for the user.  
- with command **ls /home** you wont find this new user created using **useradd <username>** , instead use **adduser**
- example: `adduser shrushti`, to check: **vim /etc/passwd OR cat /etc/passwd** , if there is entry of user in this file means user is created.

<br>

2. `passwd <username>` → sets or changes the user password  
- `passwd shrushti` → new password (password wont be visible) → retype the password (confirmation)
-  To check password : **cat /etc/shadow** (shows encrypted password)

3. `userdel <username>` → deletes a user account 
- `userdel shrushti` and everything related to this account will be deleted.

4. `su - <username>` → switch to another user
- `su - shrushti` 
- This will switch **root@ubuntu-dev:/#** to **shrushti@ubuntu-dev:~$**
- To switch back from normal user to root user: `sudo su -` this command is used.

5. `whoami` → shows the currently logged-in user 
- used to cross check which account is logged-in

6. `id <username>` → displays user ID (UID), group ID (GID), and groups   

7. `groups <username>` → shows groups the user belongs to  (one user can belong to multiple groups.)
- `groupadd <groupNmae>` to create on group where users can be added eg: devops.
- `cat /etc/group` this will show list of groups present

8. `usermod <options> <username>` → modifies an existing user (e.g., add to group, change shell) 

9.

10. Enforcing Password Policie
- Lock a user account : `passwd -l username` 
- Unlock a user account: `passwd -u username`
- Password expiration: Set password expiry days `chage -M 90 username`

---

### PRACTICAL: Switch to NON-ROOT user account and try to delete /sbin (this is one of the System Directories if gone your linux environment is currupt)

- step1: adduser shrushti
- step2: cat /etc/passwd
- step3: passwd shrushti
- step4: cat /etc/shadow
- **step5:** su - shrushti
- **step6:** rm -rf /sbin <br>
**output:**
<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/linux/assets/images/usermanag.png">
</div>

This happened cause the user didn't have permission compared to root user. 

### Question: what is the difference between uaseradd and adduser?
- `useradd <username>` command is used to instantly add user account. Mostly used for scripting purpose (automation using certain users etc.), also won't create /home directory for this user.
- `adduser` on the other hand, creates /home directory for this user account also ask for many question regarding user (fullname, room number, work phone, home phone, other)

### Question: Can you restore the old password or can you decrypt the password? 
- NO, you can't restore or decrypt the password but you can get encrypted password using `cat /etc/shadow`
- also you can change password for that user using `passwd <username>`

---
<br>

## SSH client
- An SSH client is a software tool that allows you to securely connect to a remote computer or server over a network using the Secure Shell (SSH) protocol. 
- It encrypts all communication between your local machine and the remote system, making it safe to execute commands, transfer files, and manage servers remotely. 
- Common SSH clients like **PuTTY, OpenSSH, and MobaXterm** are widely used by system administrators and DevOps engineers to access cloud servers, configure services, and perform remote troubleshooting in a secure way.