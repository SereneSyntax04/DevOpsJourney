# PART1: A reference file for important and frequently used commands.

---

## Process Management 
In Linux Process Management refers to the way the operating system handles running programs, called **processes**. 
- A process is simply an active instance of a program in execution. 
- Linux allows users and administrators to monitor, control, and manage these processes using various commands and tools. 
- Every process is assigned a unique Process ID (PID) and is usually created by a parent process, forming a hierarchy. 
- Through process management, you can view running tasks, stop unresponsive programs, change priorities, and optimize system performance, which is especially important when managing servers or cloud instances.

### commands:

1. `ps aux` is a Linux command used to display detailed information about all running processes on the system.

Breakdown of the command:

- ps = process status (shows running processes)
- a = shows processes of all users
- u = displays user-oriented format (owner, CPU, memory, etc.)
- x = includes processes not attached to a terminal (background services)


2. `ps aux | wc -l` this command will output the number of processes running
<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/linux/assets/images/ps_wc.png">
</div>

3. `ps aux | nl` this is used to list all the running process (109 total process are present in htis screenshot)
<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/linux/assets/images/ps_nl.png">
</div>

4. `ps aux` vs `ps -ef`
- `ps aux` shows all running processes in a user-oriented format (with **CPU, memory**, and user details) and is commonly used on BSD-style systems and Linux for quick monitoring.
- `ps -ef` displays all processes in full-format listing **(including PID, PPID, and start time)** and follows the System V style, making it useful for viewing process hierarchy and parent-child relationships.

5. Managing Processes:
- `kill PID`: Terminate a process by PID
- `ps aux | grep java` used to filter all process that have java. this way you'll get pid of the java process and in case you want to terminate it you can use kill command.
- `kill -9` used to **forcefully kill a process**
- `kill -STOP PID` – Stop a running process
- `kill -CONT PID` – Resume a stopped process
- `renice -n 10 -p PID` – Lower priority of a process
- `renice -n -5 -p PID` – Increase priority of a process (requires root)
**remember: (-) is for higher priority and (+) is for less priority**

[Process Management in Linux](https://github.com/iam-veeramalla/ultimate-linux-guide/tree/main/07-process-management)

---
<br>

## System Monitoring

[System Monitoring](https://github.com/iam-veeramalla/ultimate-linux-guide/tree/main/08-monitoring)

