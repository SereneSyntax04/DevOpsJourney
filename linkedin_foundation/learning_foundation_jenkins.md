# Jenkins — Beginner Friendly Introduction 🚀

<p align="center">
  <img src="./assets/images/jenkins.png" width="450" />
</p>

## What is Jenkins?

Jenkins is an **open-source automation server** used to **build, test, and deploy** applications automatically. It mainly helps teams implement **CI/CD (Continuous Integration & Continuous Delivery)** without manual effort.

- Jenkins is free, open-source, and easy to use, with a massive plugin ecosystem.
- It scales from student laptops to enterprise servers, adapting to almost any workflow.

<br>

## Key Jenkins Terms (Must-Know)

These words will come up **again and again**.

| Term              | Simple Meaning                                                |
| ----------------- | ------------------------------------------------------------- |
| **Job / Project** | A set of instructions Jenkins follows (same thing).           |
| **Build**         | Running a job (noun + verb).                                  |
| **Build Step**    | One action inside a job (e.g., run script, pull code).        |
| **Trigger**       | Event that starts a build (manual, schedule, webhook).        |
| **Plugin**        | Adds extra features to Jenkins (most power comes from these). |

📌 Reality check: Jenkins without plugins is basic. **Plugins are the real power.**

---
---
<br><br>

## System Requirements
Jenkins runs on Windows, macOS, and Linux with 256 MB RAM, 1 GB storage, and Java 21. <br>
📌 If using **Docker**, just install **Docker Desktop** (Java is already included).


---
---
<br><br>



<h1 align='center'> Install Jenkins Using Docker 🐳</h1>

```
You need admin access, 4 GB+ RAM, 10 GB disk, and basic Docker awareness (optional but helpful).
```

### Step 1: Install Docker Desktop

Docker Desktop provides the runtime + CLI needed to run Jenkins containers.
- [Docker Desktop setup](https://docs.docker.com/desktop/)

After installation, **start Docker Desktop** and wait until it shows:

> 🟢 Docker Desktop is running
<p align="center"> 
  <img src="./assets/jenkinsImg/st1.png" alt="desktop running" width="400"/> 
</p>
---

### Step 2: Verify Docker Installation

Open a **new terminal** and run:

```bash
docker --version
docker run hello-world
```

✅ If you see *"Hello from Docker"*, Docker is working correctly.
<p align="center"> 
  <img src="./assets/jenkinsImg/st2.png" alt="check docker" width="400"/>  <br>
  <img src="./assets/jenkinsImg/st3.png" alt="check container" width = "400"/>
</p>
---

### Step 3: Pull Jenkins Image (LTS + Java 21)

This image already includes Jenkins + Java.

```bash
docker pull jenkins/jenkins:lts-jdk21
```

<p align="center"> 
  <img src="./assets/jenkinsImg/st4.png" alt="pull" width="400"/>  
</p>
---

### Step 4: Create a Volume for Jenkins Data

This prevents data loss when the container stops.

```bash
docker volume create jenkins_volume
```

<p align="center"> 
  <img src="./assets/jenkinsImg/st5.png" alt="volume" width="400"/>  
</p>

📌 Without a volume → jobs, users, and configs will be lost.

---

### Step 5: Run Jenkins Container

Start Jenkins in detached mode on port **8080**.

```bash
docker run --detach \
  --volume jenkins_volume:/var/jenkins_home \
  --publish 8080:8080 \
  --name jenkins \
  jenkins/jenkins:lts-jdk21
```

<p align="center"> 
  <img src="./assets/jenkinsImg/st6.png" alt="jenkins container" width="400"/>  
</p>


#### What this command does 

| Option                | Purpose                      |
| --------------------- | ---------------------------- |
| `--detach`            | Runs container in background |
| `--volume`            | Persists Jenkins data        |
| `--publish 8080:8080` | Exposes Jenkins web UI       |
| `--name jenkins`      | Easy container reference     |

---

### Step 6: Get Initial Admin Password

Jenkins generates a one-time password on first startup. **(run command in powershell if using windows.)**

```powershell
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

📋 Copy this password — you’ll need it in the browser. 

---

### Step 7: Finish Setup in Browser

Open your browser and go to:

👉 **[http://localhost:8080](http://localhost:8080)**

<p align="center"> 
  <img src="./assets/jenkinsImg/st7.png" alt="setup" width="400"/>  
</p>

* Paste the admin password
* Install suggested plugins
* Create your admin user

🎉 Jenkins is now running inside Docker!

---
<br>


## Finish Jenkins Installation 

### Step 1: Unlock Jenkins

After opening Jenkins at **[http://localhost:8080](http://localhost:8080)**, you must unlock it.

```bash
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

* Copy the password
* Paste it into the Jenkins unlock screen

<br>

### Step 2: Install Suggested Plugins

* Choose **Install suggested plugins**
* Wait 1–2 minutes for installation to finish

These plugins cover most common Jenkins use cases.

<p align="center"> 
  <img src="./assets/jenkinsImg/st8.png" alt="plugin installation" width="400"/>  
</p>

<br>

### Step 3: Create Admin User

* Enter **username & password**
* Add **name and email** (can be dummy, but valid format)
* Click **Save and Continue**


<p align="center"> 
  <img src="./assets/jenkinsImg/st9.png" alt="create admin user" width="400"/> 
</p>

<br>

### Step 4: Instance Configuration

* Accept the default Jenkins URL
* Click **Save and Finish**

<p align="center"> 
  <img src="./assets/jenkinsImg/st10.png" alt="finish setup" width="400"/> 
</p>

🎉 Jenkins setup is complete.

<br>

## Jenkins User Interface (What Matters)

| Menu                      | Purpose                 |
| ------------------------- | ----------------------- |
| **New Item**              | Create jobs (most used) |
| **Manage Jenkins**        | System configuration    |
| **Build Queue**           | Jobs waiting to run     |
| **Build Executor Status** | Jobs currently running  |

📌 You may see a security warning about controller builds — safe to ignore for learning.

<p align="center"> 
  <img src="./assets/jenkinsImg/st11.png" alt="finish setup" width="400"/> 
</p>

<br>

## Manage Plugins (Basics)

Path: **Manage Jenkins → Plugins**

<p align="center"> 
  <img src="./assets/jenkinsImg/st12.png" alt="finish setup" width="400"/> 
</p>

| Action    | What It Does                       |
| --------- | ---------------------------------- |
| Available | Install new plugins                |
| Installed | View / disable / uninstall plugins |
| Disable   | Temporarily turn off a plugin      |
| Uninstall | Completely remove a plugin         |

🔁 After uninstalling a plugin, restart Jenkins:

```
http://localhost:8080/safeRestart
```

<br>

## Manage Tools (Basics)

Path: **Manage Jenkins → Tools**

Used to configure tools Jenkins jobs depend on.

| Tool  | Example Use              |
| ----- | ------------------------ |
| Java  | Build Java apps          |
| Maven | Build & package projects |
| Git   | Source code checkout     |

### Example: Add Maven

* Click **Add Maven**
* Name it (e.g., `Maven-3.9.9`)
* Enable **automatic installation**
* Click **Save**

📌 Jenkins installs the tool automatically when a job needs it.

---
---
<br><br>


<h1 align='center'>Chapter 2: Jenkins Job</h1>

# Your First Jenkins Job (Hello Jenkins)

Just like *Hello World* in programming, this job confirms Jenkins is working correctly.

### Steps to Create the Job

1. From Jenkins Dashboard → click **New Item**
2. Enter job name: `Hello-Jenkins`
   📌 Avoid spaces in job names (CLI & API friendly)
3. Select **Freestyle Project** → Click **OK**

---

### Configure the Job

Scroll to **Build** section → **Add Build Step**

| System                 | Build Step                    |
| ---------------------- | ----------------------------- |
| Windows                | Execute Windows batch command |
| Linux / macOS / Docker | Execute Shell                 |

Command to add:

```bash
echo "Hello, Jenkins"
```

Click **Apply** → **Save**

---

### Run the Job

* Click **Build Now**
* Under **Build History**:

  * 🟢 Green check → Success
  * 🔴 Red X → Failure

Click the build number or check mark to view **Console Output**.

---

## Jenkins Job Types (Overview)

| Job Type                 | Purpose                          |
| ------------------------ | -------------------------------- |
| **Freestyle**            | Most common, flexible jobs       |
| **Pipeline**             | CI/CD as code (Jenkinsfile)      |
| **Multi-configuration**  | Same job, multiple parameters    |
| **Multibranch Pipeline** | Different branches, same repo    |
| **Organization Folder**  | Auto-detect repos                |
| **Folder**               | Organize jobs (not a job itself) |

📌 Course focus: **Freestyle jobs**

---

## Job Configuration Sections (What Matters)

### General

| Option             | Purpose                    |
| ------------------ | -------------------------- |
| Description        | Explains what the job does |
| Discard Old Builds | Prevents disk from filling |

---

### Source Code Management (SCM)

Used to pull code from repositories.

| Feature     | Use                   |
| ----------- | --------------------- |
| Git URL     | Repo location         |
| Credentials | Secure repo access    |
| Branch      | Code version to build |

Works with GitHub, GitLab, Bitbucket.

---

### Build Triggers (How Jobs Start)

| Trigger                | Use Case                         |
| ---------------------- | -------------------------------- |
| Manual                 | Click **Build Now**              |
| Build After Other Jobs | Job dependencies                 |
| Build Periodically     | Scheduled (cron)                 |
| GitHub Webhook         | CI on code changes               |
| Poll SCM               | Not recommended (resource heavy) |

📌 Webhooks are preferred over polling.

---

### Build Environment

| Option           | Why It’s Useful         |
| ---------------- | ----------------------- |
| Delete Workspace | Clean build every run   |
| Inject Secrets   | Secure passwords & keys |
| Timeout          | Stop stuck jobs         |

---

### Build Steps (What Jenkins Executes)

| Type           | Example          |
| -------------- | ---------------- |
| Execute Shell  | Bash scripts     |
| Execute Batch  | Windows commands |
| Maven / Gradle | Java builds      |

✔ Multiple build steps allowed
✔ Steps can be reordered

---

### Post-Build Actions

Actions after job finishes.

| Action             | Purpose           |
| ------------------ | ----------------- |
| Archive Artifacts  | Save build output |
| Trigger Job        | Chain jobs        |
| Email Notification | Notify users      |

---

## Run & Monitor Jobs

### Build Status Indicators

| Icon           | Meaning   |
| -------------- | --------- |
| 🟢 Green Check | Success   |
| 🔴 Red X       | Failure   |
| 🔵 Blue Circle | First run |
| 🔄 Spinning    | Running   |

Each run gets a unique **Build ID**.

---

## Console Output (Logs)

* Click build number → **Console Output**
* Shows:

  * Commands executed
  * Output logs
  * Errors (if any)

📌 Console updates **live** while job runs.

---

## Simulating a Failed Build

Linux / macOS / Docker:

```bash
exit 1
```

Windows (Batch):

```bat
exit /B 1
```

Any non-zero exit code → **Build Failure**

---

## Monitor Build Trends

* Expand **Build History**
* View:

  * Success vs Failure timeline
  * Build duration trends

Useful for identifying slow or unstable jobs.

---
---
<br><br>


<h1 align='center'>Chapter 3: Job Workspaces,Artifacts and Parameters.</h1>

#



---
---
<br><br>
<h1 align='center'>Deletion</h1>
- Jenkins runs in a Docker container.
- Deleting the container removes Jenkins temporarily, but deleting the container + volume removes everything (jobs, users, configs).

## Delete only Jenkins container (data stays)
docker rm -f jenkins

## Delete Jenkins container + all data (clean wipe)
docker rm -f jenkins
docker volume rm jenkins_volume

## (Optional) Remove Jenkins image
docker rmi jenkins/jenkins:lts-jdk21

---
---
<br><br>


---
<br><br>

[Click here to redirect to INDEX](../README.md) 