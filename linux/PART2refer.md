# PART1: A reference file for important and frequently used commands.

---

## Process Management 
In Linux Process Management refers to the way the operating system handles running programs, called **processes**. 
- A process is simply an active instance of a program in execution. 
- Linux allows users and administrators to monitor, control, and manage these processes using various commands and tools. 
- Every process is assigned a unique Process ID (PID) and is usually created by a parent process, forming a hierarchy. 
- Through process management, you can view running tasks, stop unresponsive programs, change priorities, and optimize system performance, which is especially important when managing servers or cloud instances.

### Commands to VIEW/CHECK processes :

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
<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/linux/assets/images/ps_aux.png"> <img src="/linux/assets/images/ps_ef.png">
</div>

5. `ps aux | head -n 10` command used to display beginning only 10 process.
- `ps aux --sort=-%cpu | head -n 5` is used to sort top 10 by CPU usage

6. `ps aux | tail -n 10`  command used to display ending  10 process.

<br>

### Commands to KILL/STOP/RESUME processes :

We use **kill** to stop a running process. A process may need to be killed when:

1️⃣ Process is stuck (hung) <br>
2️⃣ High CPU or Memory usage <br>
3️⃣ Wrong process started by mistake <br>
4️⃣ Freeing system resources <br>

1. `Kill` processes:
- `ps aux | grep java` used to filter all process that have 'java' , this way you'll get pid of the java process and in case you want to terminate it you can use kill command.
- `kill PID (Process ID).`: **Terminate** a process by PID
- `kill -9` used to **forcefully kill a process**

2. `Stop` and `Start` process:
- `kill -STOP PID` – **Stop** a running process
- `kill -CONT PID` – **Resume** a stopped process

<br>

### `PRIORITY of process`:
- `nice -n 10 command` – **Run** a command with a specific priority
- `renice -n 10 -p PID` – Change to **Lower** priority of a process (existing process)
- `renice -n -5 -p PID` – **Increase** priority of a process (requires root) (existing process)

**remember: (-) is for higher priority and (+) is for less priority**

[Process Management in Linux](https://github.com/iam-veeramalla/ultimate-linux-guide/tree/main/07-process-management)

---
<br>

## System Monitoring

System monitoring in Linux is the process of observing and analyzing the system’s performance, resource usage, and overall health in real time. It involves tracking key components such as CPU utilization, memory consumption, disk usage, network activity, and running processes to ensure the system operates efficiently and reliably.

By continuously monitoring these resources, administrators and DevOps engineers can identify performance bottlenecks, detect unusual behavior, prevent system failures, and troubleshoot issues before they impact applications or services.

commonly used commands:

1. `top` – Displays real-time system processes along with CPU and memory usage.
2. `htop` – An interactive and user-friendly tool to monitor processes, CPU, and memory usage.
3. `nice & renice` – Used to set and adjust the priority of processes to manage CPU allocation.
4. `vmstat` – Shows system performance statistics related to memory, CPU, and I/O activity.
<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/linux/assets/images/vmstat.png">
</div>

5. `nproc` – Displays the number of **CPU cores available** on the system.
6. `free -h` – Shows the total, used, and available **memory** in a human-readable format.
7. `df -h` – Displays disk space usage of all mounted file systems in a human-readable format.
8. `du -sh` – Shows the total disk usage of a specific file or directory in a summarized, human-readable format.


```
cpu - npoc, htop
memory - free -h, htopdf 
disk - df -h, du -sh *
```

[System Monitoring](https://github.com/iam-veeramalla/ultimate-linux-guide/tree/main/08-monitoring)

