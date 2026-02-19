# PART1: A reference file for important and frequently used commands.

---

## Basic linux command

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

Example: ubuntu@ubuntu-dev:~$  
- `ubuntu` → the current logged-in user (non-root user)  
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

<br>

## User Management 

1. `useradd <username>` → creates a new user account  
- adduser or useradd both commands can be used to create an user.
remember, useradd won't create home directory for the user.
- example: `adduser shrushti`, to check: vim /etc/passwd , if there is entry of user in this file means user is created.

<br>

2. `passwd <username>` → sets or changes the user password  
-  To check password : cat /etc/shadow (shows encrypted password)

 `usermod <options> <username>` → modifies an existing user (e.g., add to group, change shell)  

 `userdel <username>` → deletes a user account  

 `id <username>` → displays user ID (UID), group ID (GID), and groups 

 `whoami` → shows the currently logged-in user  

 `groups <username>` → shows groups the user belongs to  
 `su <username>` → switch to another user  
 `sudo <command>` → run a command with superuser (root) privileges
