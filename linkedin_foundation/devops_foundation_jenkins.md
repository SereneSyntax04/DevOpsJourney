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

<p align="center"> 
  <img src="./assets/jenkinsImg/st13.png" alt="desktop running" width="400"/> <br>
  <img src="./assets/jenkinsImg/st14.png" alt="desktop running" width="400"/>
</p>

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

<p align="center"> 
  <img src="./assets/jenkinsImg/st15.png" alt="desktop running" width="400"/> <br>
  <img src="./assets/jenkinsImg/st16.png" alt="desktop running" width="400"/> 
</p>

Click **Apply** → **Save**

---

### Run the Job

* Click **Build Now**
* Under **Build History**:

  * 🟢 Green check → Success
  * 🔴 Red X → Failure

<p align="center"> 
  <img src="./assets/jenkinsImg/st17.png" alt="desktop running" width="400"/> <br>
</p>

Click the build number or check mark to view **Console Output**.

<p align="center"> 
  <img src="./assets/jenkinsImg/st18.png" alt="desktop running" width="400"/> 
</p>

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

## Monitor Build Trends

* Expand **Build History**
* View:

  * Success vs Failure timeline
  * Build duration trends

Useful for identifying slow or unstable jobs.


## jenkins Task
[Task 1: Automate System Monitoring with Jenkins](jenkinsTask.md)

---
---
<br><br>


<h1 align='center'>Chapter 3: Job Workspaces,Artifacts and Parameters.</h1>

## Using a Global Build Tool in Jenkins

Jenkins allows you to configure tools **once** and reuse them across multiple jobs. This ensures consistency and avoids repeating setup for every project.

---

## Tools Used

| Tool  | Purpose                             |
| ----- | ----------------------------------- |
| Git   | Fetch source code from repositories |
| Maven | Build and package Java applications |


## High-Level Flow


1️⃣ Configure Git and Maven in Manage Jenkins → Tools
<div style="display:flex; gap:10px;"> <img src="assets/jenkinsImg/st25.png" width="400"> <img src="assets/jenkinsImg/st26.png" width="400"> </div>
<br>



2️⃣ Create a Jenkins Job and Connect GitHub Repository
<div style="display:flex; gap:10px;"> <img src="assets/jenkinsImg/st27.png" width="300"> <img src="assets/jenkinsImg/st28.png" width="300"> <img src="assets/jenkinsImg/st29.png" width="300"> </div>
<br>

3️⃣ Build the Project Using Maven
<div style="display:flex; gap:10px;"> <img src="assets/jenkinsImg/st30.png" width="400"> <img src="assets/jenkinsImg/st31.png" width="400"> </div>
<br>

4️⃣ Run the Compiled Java Application
<div style="display:flex; gap:10px;"> <img src="assets/jenkinsImg/st32.png" width="500"> </div>

---
<br>

# Job Workspace

Each Jenkins job gets a dedicated **workspace** on the server.

### What the Workspace Contains

* Source code checked out from Git
* Build outputs (JARs, logs, reports)
* Temporary files used during the build

<div style="display:flex; gap:10px;"> <img src="assets/jenkinsImg/st33.png" width="00"> </div>

### Workspace Actions

| Action             | Description                 |
| ------------------ | --------------------------- |
| Browse Workspace   | View files and folders      |
| Wipe Out Workspace | Deletes all workspace files |

⚠️ No undo for workspace deletion — next build recreates it.

### Automatic Cleanup Options

* **Before build**: Environment → *Delete workspace before build starts*
* **After build**: Post-build action → *Delete workspace when job is done*

<br>

# Managing Artifacts

Artifacts are **outputs produced by a build**.

### Common Artifact Examples

* JAR / WAR files
* Executables
* Reports and logs

### Archiving Artifacts

1. Go to **Post-Build Actions**
2. Select **Archive the artifacts**
3. Provide file path (relative to workspace)

#### Tips

* Jenkins suggests correct paths if entered incorrectly
* Use wildcards to simplify paths:

```
**/*.jar
```

### Result

* Artifacts get a **direct download link**
* Persist across builds

<div style="display:flex; gap:10px;"> <img src="assets/jenkinsImg/st34.png" width="300"> <img src="assets/jenkinsImg/st35.png" width="300"> <img src="assets/jenkinsImg/st36.png" width="300"></div>
<br>

# Parameters and Environment Variables

Parameterized jobs make Jenkins builds **reusable and flexible**.

### Key Concepts

* Parameters become **environment variables**
* Typically written in **UPPERCASE**
* Case-sensitive on Linux/macOS/Docker

### Accessing Variables

| Platform               | Syntax       |
| ---------------------- | ------------ |
| Windows                | `%VAR_NAME%` |
| Linux / macOS / Docker | `$VAR_NAME`  |

### Useful Built-in Variables

| Variable     | Purpose                  |
| ------------ | ------------------------ |
| BUILD_ID     | Unique build identifier  |
| BUILD_NUMBER | Incremental build number |

<br>

## String Parameters

Used for free-text input like versions.

### Example
* Name: `VERSION`
* Default: `1.0.0`
* Description: Version number for build

<div style="display:flex; gap:10px;"> <img src="assets/jenkinsImg/st37.png" width="400"> <img src="assets/jenkinsImg/st38.png" width="400"> </div>


### Result
* Job shows **Build with Parameters**
* Input value is available during execution

<div style="display:flex; gap:10px;"> <img src="assets/jenkinsImg/st39.png" width="300"> <img src="assets/jenkinsImg/st40.png" width="300"> <img src="assets/jenkinsImg/st41.png" width="300"></div>

<br>


## Choice Parameters

Used to restrict input to predefined values.

### Example
* Name: `ENVIRONMENT`
* Choices:

  * development
  * staging
  * production

<div style="display:flex; gap:10px;"> <img src="assets/jenkinsImg/st42.png" width="300"> <img src="assets/jenkinsImg/st43.png" width="300"> <img src="assets/jenkinsImg/st44.png" width="300"></div>
<br>
<div style="display:flex; gap:10px;"> <img src="assets/jenkinsImg/st45.png" width="300"> <img src="assets/jenkinsImg/st46.png" width="300"> <img src="assets/jenkinsImg/st47.png" width="300"></div>

### Benefit
Prevents invalid inputs and enforces consistency.

<br>

## Boolean Parameters

Used for on/off decisions.

### Example
* Name: `RUN_TESTS`
* Checkbox input
* Default: unchecked (`false`)

```bash
#!/bin/bash
echo "RUN_TESTS = $RUN_TESTS"
if [ "$RUN_TESTS" = "true" ];
then
    echo "RUNNING TESTS!";
else
    echo "No tests will be run...";
fi
```

<div style="display:flex; gap:10px;"> <img src="assets/jenkinsImg/st48.png" width="300"> <img src="assets/jenkinsImg/st49.png" width="300"> <img src="assets/jenkinsImg/st50.png" width="300"></div>
<br>
<div style="display:flex; gap:10px;"> <img src="assets/jenkinsImg/st51.png" width="300"> </div>

### Usage
Scripts can conditionally execute steps based on parameter value.

<br>

## Scheduling Jobs (Cron)

Jenkins can run jobs automatically using **Cron-style schedules**.

### Cron Fields Order

<div style="display:flex; gap:10px;"> <img src="assets/jenkinsImg/cron-style.png" width="500"> </div>

```
MINUTE HOUR DAY MONTH DAY_OF_WEEK
```

### Common Examples

| Schedule    | Meaning               |
| ----------- | --------------------- |
| `0 0 * * *` | Every day at midnight |
| `H * * * *` | Once every hour       |
| `@daily`    | Once per day          |
| `@midnight` | Overnight (12–3 AM)   |

# Jenkins Enhancement: `H`

* Spreads job execution to reduce server load
* Prevents multiple jobs from running at the same second

### Time Zone Awareness

* Schedules follow **server time zone**
* Can specify explicitly:

```
TZ=Europe/London
```

<div style="display:flex; gap:10px;"> <img src="assets/jenkinsImg/st52.png" width="300"> <img src="assets/jenkinsImg/st53.png" width="300"> <img src="assets/jenkinsImg/st54.png" width="300"></div>

### Verification

* Jenkins shows last and next run time
* Build log states: *Started by timer*

<br>

## jenkins Task
[Task 2: Use a Build Tool and Parameters](jenkinsTask.md)

---
---
<br><br>



<h1 align='center'>Chapter 4: Organize Jobs with Views and Folders.</h1>

# Why Views and Folders Matter

As Jenkins grows, job sprawl becomes real. In large teams (for example, multiple apps per team), you can easily end up with **hundreds of jobs**. Views and folders exist to keep Jenkins **usable, searchable, and sane**.

* **Views** → Logical filters to *see* jobs
* **Folders** → Physical-like structure to *store* jobs

<br>

## Views in Jenkins

### What is a View?

A **View** is a filtered dashboard that displays jobs based on rules you define.

Think of it as:

> “Show me only the jobs I care about right now.”

Key points:

* Views do **not** move jobs
* A job can appear in **multiple views**
* The default **All** tab is itself a view

<br>

### Create a View (List View)

**Steps:**

1. On Jenkins dashboard, click **➕ (plus)** next to the *All* tab
2. Enter a **View Name** (example: `Build`)
3. Select **List View** → **Create**
4. (Optional) Add a description

<br>

### Filter Jobs Using Regular Expressions

Instead of manually selecting jobs, use **regex**.

Example:

```text
.*BUILD.*
```

Meaning:

* `.*` → match any characters
* `BUILD` → job name contains "build"

✔ Automatically includes **existing and future jobs** with `build` in their name.

Repeat the same for:

* `TEST` → `.*TEST.*`
* `DEPLOY` → `.*DEPLOY.*`

<br>

### Recursive Views (Important)

By default, views only show jobs at the **same level**.

If jobs are inside folders:

1. Edit the view
2. Enable **Recurse in subfolders**

✔ Now the view displays jobs across all folders.

<br>

## Folders in Jenkins

### What is a Folder?

A **Folder** is a container that organizes jobs like directories in a file system.

Folders can contain:

* Jobs
* Views
* Other folders

Each folder has its **own namespace**, meaning:

* Jobs inside folders can share names
* Isolation improves clarity and access control

<br>

### Create a Folder

**Steps:**

1. From Jenkins dashboard → **New Item**
2. Enter folder name (example: `Cyclones`)
3. Select **Folder** → **OK**
4. Add a description
5. Click **Save**

<br>

### Move Jobs into a Folder

1. Open job menu (dropdown)
2. Select **Move**
3. Choose destination folder
4. Confirm

⚠ Jobs must be moved **one at a time** (no drag-and-drop).

<br>

### Views + Folders = Best Practice

The most scalable setup:

* **Folders** → Organize by team/project
* **Views** → Filter by job type (Build/Test/Deploy)

✔ Clean dashboard
✔ Faster navigation
✔ Enterprise-ready structure

<br>

## Search with Command Palette

The **Command Palette** provides instant navigation.

### Shortcut

* **macOS** → `Cmd + K`
* **Windows/Linux** → `Ctrl + K`

### What You Can Search

* Jobs
* Folders
* Views
* Users
* Builds

Examples:

* `Cyclones` → shows folder + jobs
* `build` → jobs + views containing "build"
* `Cyclones deploy 1` → first deploy build

✔ Selecting a result jumps directly to it.

<br>

## Deleting Views and Folders (Very Important)

### Deleting a View

* Removes only the **view**
* Jobs inside the view are **NOT deleted**

Safe operation ✔

<br>

### Deleting a Folder

* Deletes the folder
* **Deletes ALL contents inside it**

  * Jobs
  * Views
  * Subfolders

🚨 **Permanent and destructive**

> Always double-check before deleting folders.



## jenkins Task
[Task 3: Create Folders and Views](jenkinsTask.md)

---
---
<br>





# Jenkins Pipeline as Code – Understanding & Error Resolution

## Overview

Earlier, Jenkins jobs were created using **Freestyle projects**, which required manual configuration through the UI.  
Jenkins also supports a modern and industry-standard approach called **Pipeline as Code**.

With Pipeline as Code, the entire CI/CD workflow is defined in a file called a **Jenkinsfile** and stored in source control.

---

## What is Jenkins Pipeline?

A **Jenkins Pipeline** is:

- Defined using a `Jenkinsfile`
- Stored in version control systems like Git
- Fully versioned, auditable, and reusable
- Written using Groovy-based syntax

This approach aligns with DevOps best practices.

📄 [Refer to the pipeline code](/linkedin_foundation/jenkinsfile.md)

---

## Pipeline Structure

| Component | Description |
|---------|------------|
| Pipeline | Complete job definition |
| Stages | Logical phases such as Build, Test, Deploy |
| Steps | Commands executed inside each stage |

---

## Benefits of Pipeline as Code

- Configuration stored as code
- Easy to maintain and update
- Clear visual representation of stages
- Better debugging and error tracking
- Industry-standard CI/CD implementation

---

## Pipeline Output

<div style="display:flex; gap:10px;"> <img src="assets/jenkinsImg/st92.png" width="500"> <img src="assets/jenkinsImg/st93.png" width="500"> </div>
<br>
<div style="display:flex; gap:10px;"> <img src="assets/jenkinsImg/st94.png" width="300"></div>


---

## Error Handling & Troubleshooting

While executing the pipeline, the following errors were encountered and resolved.

---

### ❌ Error 1: Maven Could Not Find `pom.xml`

#### Error Message
```bash
The goal you specified requires a project to execute but there is no POM in this directory
(/var/jenkins_home/workspace/java-calculator-pipeline)
```

<div style="display:flex; gap:10px;"> <img src="assets/jenkinsImg/st95.png" width="700" height="150"> </div>

#### Root Cause

* Jenkins workspace did not contain the project source code
* `pom.xml` was missing
* Maven requires `pom.xml` to identify the project structure

As a result, the command `mvn clean test` failed immediately.

---

### ✅ Solution: Use Pipeline Script from SCM

To fix this, the project source code must be pulled from Git.

#### Steps Followed

1. Open Jenkins job → **Configure**
2. Go to **Pipeline**
3. Change **Definition** to:

   ```
   Pipeline script from SCM
   ```
4. Select **SCM: Git**
5. Provide repository details:

   ```
   Repository URL: https://github.com/managedkaos/java-calculator.git
   Branch: main (or master)
   Script Path: Jenkinsfile
   ```

<div style="display:flex; gap:10px;"> <img src="assets/jenkinsImg/st96.png" width="400"> <img src="assets/jenkinsImg/st97.png" width="400"> </div>

This ensures:

* Jenkins clones the repository
* `pom.xml` is available in the workspace
* Maven commands execute successfully

---

### ❌ Error 2: Maven Tool Version Mismatch

#### Issue

The pipeline specified:

```groovy
maven 'maven-3.9.9'
```

But Jenkins had a different Maven version configured:

```
maven-3.9.12
```

This caused tool resolution issues during pipeline execution.

<div style="display:flex; gap:10px;"> <img src="assets/jenkinsImg/st98.png" width="700" height="200"> </div>

---

### ✅ Solution: Configure Correct Maven Version

Steps to fix:

1. Go to **Manage Jenkins**
2. Open **Global Tool Configuration**
3. Under **Maven installations**
4. Add a new Maven version:

   ```
   Name: maven-3.9.9
   ```

   *(or update the Jenkinsfile to match the installed version)*

Once the versions matched, the pipeline executed successfully.

<div style="display:flex; gap:10px;"> <img src="assets/jenkinsImg/st99.png" width="400"> </div>

---

## Conclusion

This implementation demonstrates:

* Practical use of **Pipeline as Code**
* Real-world CI/CD pipeline setup
* Troubleshooting common Jenkins & Maven issues
* Industry-standard DevOps practices

By defining pipelines in code and storing them in Git, Jenkins pipelines become more reliable, maintainable, and production-ready.

<div style="display:flex; gap:10px;"> <img src="assets/jenkinsImg/st100.png" width="500"> </div>

---

✅ **Skills Demonstrated**

* Jenkins Pipeline (Declarative)
* Maven build automation
* Git-based CI/CD
* Error analysis and resolution


---
<br>





## Build Agents and Cloud Runners

### What is a Build Agent?

A **build agent** is a separate machine that Jenkins uses to run jobs.

Benefits:

* Parallel execution
* OS-specific builds
* Tool isolation

---

### Cloud-Based Agents

Jenkins can dynamically create agents using cloud providers:

* AWS
* Azure
* Google Cloud

Using plugins:

* Agents spin up **on demand**
* Jobs run
* Agents are destroyed

✔ Faster builds
✔ Lower cloud cost
✔ Massive scalability

---
---
<br><br>



# Jenkins Deletion (Docker-Based Setup)

## Jenkins Running Inside Docker

In this setup, Jenkins is running inside a **Docker container** with its data stored in a **Docker volume**.

- The **container** holds the running Jenkins process
- The **volume** stores persistent data (jobs, users, plugins, configs)
- Deleting only the container does **NOT** delete Jenkins data
- Deleting both container and volume results in a **complete wipe**

---

## Check Existing Jenkins Resources (Recommended)

Before deletion, verify what exists:

```bash
docker ps -a
docker volume ls
````

---

## Delete Only Jenkins Container 

This stops and removes the Jenkins container, but **keeps all data intact**.

```bash
docker rm -f jenkins
```

✔ Jenkins UI is gone
✔ Jobs, users, plugins remain in the volume
✔ Jenkins can be recreated using the same volume

---

## Delete Jenkins Container + All Data (Permanent Deletion)

This performs a **clean wipe** of Jenkins.

```bash
docker rm -f jenkins
docker volume rm jenkins_volume
```

⚠️ **Warning:**
This permanently deletes:

* All Jenkins jobs
* Users & credentials
* Plugins
* Configuration files

Use this only when you want a **fresh Jenkins installation**.

---

## Optional: Remove Jenkins Docker Image

Remove the Jenkins image from the local system:

```bash
docker rmi jenkins/jenkins:lts-jdk21
```

If the image is in use, force removal:

```bash
docker rmi -f jenkins/jenkins:lts-jdk21
```

---

## Complete Cleanup (Container + Volume + Image)

```bash
docker rm -f jenkins
docker volume rm jenkins_volume
docker rmi jenkins/jenkins:lts-jdk21
```

---

## Best Practice

* Always use **named volumes** for Jenkins data
* Never delete volumes unless a clean reset is required
* Backup volumes before permanent deletion



---
---
<br><br>

[Click here to redirect to INDEX](../README.md) 