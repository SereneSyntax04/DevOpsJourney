
# Task 1: Automate System Monitoring with Jenkins

## Objective
Create a Jenkins freestyle job that generates a daily system report from the machine where Jenkins is running and archives the report.

---

## Job Configuration
- **Job Name:** system-report  
- **Job Type:** Freestyle Project  
- **Report File:** system-report.txt  
- **Schedule:** Once per day  

---

## Step 1: Create the Job
1. Open Jenkins Dashboard
2. Click **New Item**
3. Enter name: `system-report`
4. Select **Freestyle project**
5. Click **OK**
<p align="center"> 
  <img src="/cicd/assets/jenkinsImg/st19.png" alt="desktop running" width="500"/> 
</p>

---

## Step 2: Configure Build Trigger
Schedule the job to run once a day. Options include the following, among others:
- 0 0 * * *
- H H * * *
- @daily
- @midnight
<p align="center"> 
  <img src="/cicd/assets/jenkinsImg/st20.png" alt="desktop running" width="500"/> 
</p>

---

## Step 3: Add Build Step

### For macOS / Linux / Docker

Add **Execute shell**:

```bash
#!/bin/bash

REPORT_FILE="system-report.txt"

echo "System Report - $(date)" > $REPORT_FILE
echo "" >> $REPORT_FILE

echo "Disk Usage:" >> $REPORT_FILE
df -h >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "Memory Usage:" >> $REPORT_FILE
free -m >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "Running Processes:" >> $REPORT_FILE
ps aux --sort=-%mem | head -10 >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "Logged-in Users:" >> $REPORT_FILE
who >> $REPORT_FILE
```

<p align="center"> 
  <img src="/cicd/assets/jenkinsImg/st21.png" alt="desktop running" width="500"/> 
</p>

---

### For Windows

Add **Execute Windows batch command**:

```bat
@echo off

set REPORT_FILE=system-report.txt

echo System Report - %DATE% %TIME% > %REPORT_FILE%
echo. >> %REPORT_FILE%

echo Disk Usage: >> %REPORT_FILE%
wmic logicaldisk get caption,freespace,size >> %REPORT_FILE%
echo. >> %REPORT_FILE%

echo Memory Status: >> %REPORT_FILE%
systeminfo | findstr /C:"Total Physical Memory" /C:"Available Physical Memory" >> %REPORT_FILE%
echo. >> %REPORT_FILE%

echo Running Processes: >> %REPORT_FILE%
tasklist >> %REPORT_FILE%
echo. >> %REPORT_FILE%

echo Logged-in Users: >> %REPORT_FILE%
query user >> %REPORT_FILE%
```

---

## Step 4: Archive Artifacts

1. Go to **Post-build Actions**
2. Select **Archive the artifacts**
3. Enter:

```text
system-report.txt
```

<p align="center"> 
  <img src="/cicd/assets/jenkinsImg/st22.png" alt="desktop running" width="500"/> 
</p>

---

## Step 5: Verification

1. Click **Build Now**
2. Confirm build status is **SUCCESS**
3. Open **Console Output** to verify execution
4. Download `system-report.txt` from **Artifacts**

<p align="center"> 
  <img src="/cicd/assets/jenkinsImg/st23.png" alt="desktop running" width="500"/>  <br><br>
  <img src="/cicd/assets/jenkinsImg/st24.png" alt="desktop running" width="500"/>
</p>

---

## Result

The Jenkins job runs daily, collects system information, and archives the report for future reference.

---
<br><br>





# Task 2: Use a Build Tool and Parameters (Jenkins)

## Challenge Overview

* Configure **Git** and **Maven** tools in Jenkins
* Create a **freestyle job** named `java-calculator`
* Use **build parameters**
* Fetch code from a **Git repository**
* Build the application with **Maven**
* Run the Java JAR with parameters
* Archive the **JAR** and **JUnit test results**

Estimated time: **10–15 minutes**

---

## Step 1: Install Required Tools

Navigate to:

**Manage Jenkins → Tools**

### Git Configuration

* Under **Git installations**:

  * Name: `Default`
  * **Windows only**: Provide the full path to `git.exe`

    * Example: `C:\Program Files\Git\bin\git.exe`

<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st55.png" width="300"> </div>

### Maven Configuration

* Under **Maven installations**:

  * Name: `maven-3.9.12`
  * Enable **Install automatically**
  * Select the latest available Maven version

<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st56.png" width="300"> </div>

Save the configuration.

---

## Step 2: Create a Freestyle Project

* Go to **Dashboard → New Item**
* Select **Freestyle project**
* Project name: `java-calculator`
* Click **OK**

<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st57.png" width="300"> </div>

---

## Step 3: Add Build Parameters

Navigate to **This project is parameterized** and add the following parameters:

### Choice Parameter

* **Name:** `OPERATION`
* **Choices:**

  ```
  add
  subtract
  multiply
  divide
  ```
<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st58.png" width="300"> </div>

### String Parameters

1. **Name:** `NUMBER_1`

   * Default value: `10`

2. **Name:** `NUMBER_2`

   * Default value: `5`

<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st59.png" width="300"> <img src="/cicd/assets/jenkinsImg/st60.png" width="300"> </div>

---

## Step 4: Configure Source Code Management

* Select **Git**
* **Repository URL:**

  ```
  https://github.com/managedkaos/java-calculator.git
  ```
* **Branch Specifier:**

  ```
  */main
  ```
<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st61.png" width="300"> </div>

---

## Step 5: Add Maven Build Step

Add build step:

**Invoke top-level Maven targets**

* **Maven Version:** `maven-3.9.12`
* **Goals:**

  ```
  clean test package
  ```

<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st62.png" width="300"> </div>

---

## Step 6: Add Platform-Specific Build Step

### For Windows

Add build step: **Execute Windows batch command**

```bat
@echo off

echo         Build: %BUILD_ID%
echo     Operation: %OPERATION%
echo  First number: %NUMBER_1%
echo Second number: %NUMBER_2%

java -jar target\calculator-1.0-SNAPSHOT.jar %OPERATION% %NUMBER_1% %NUMBER_2%
```

### For macOS / Linux / Docker

Add build step: **Execute shell**

```bash
#!/bin/bash

echo "        Build: $BUILD_ID"
echo "    Operation: $OPERATION"
echo " First number: $NUMBER_1"
echo "Second number: $NUMBER_2"

java -jar target/calculator-1.0-SNAPSHOT.jar $OPERATION $NUMBER_1 $NUMBER_2
```

<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st63.png" width="300"> </div>

---

## Step 7: Configure Post-Build Actions

### Archive Artifacts

* **Files to archive:**

  ```
  **/target/calculator-1.0-SNAPSHOT.jar
  ```

<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st64.png" width="400"> </div>

### Publish JUnit Test Results

* **Test report XMLs:**

  ```
  **/target/surefire-reports/*.xml
  ```

<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st65.png" width="400"> </div>

---

## Step 8: Verify the Job

1. Click **Build with Parameters**
2. Choose an operation (e.g., `add`)
3. Keep default values or modify numbers
4. Run the build

<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st66.png" width="300"> <img src="/cicd/assets/jenkinsImg/st67.png" width="300"> </div>

### Try with different values
<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st68.png" width="300"> <img src="/cicd/assets/jenkinsImg/st69.png" width="300"> </div>

### Verification Checklist

* Console Output shows parameter values
* Maven build completes successfully
* Calculator result is displayed
* JAR file appears under **Artifacts**
* Test results are published
<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st70.png" width="400"></div>

---

## Result

The Jenkins job successfully:

* Uses configured tools (Git & Maven)
* Accepts runtime parameters
* Builds and tests a Java application
* Executes the application logic
* Archives build and test artifacts

---
<br><br>





# Task 3: Create Folders and Views (Jenkins)

## Challenge Overview

The **Engineering** and **Accounting** teams are using Jenkins for building and deploying applications. To keep Jenkins scalable and easy to navigate, jobs are organized using:

* Freestyle jobs
* Views based on job type
* Folders based on teams
* Command Palette for quick navigation

Estimated time: **10–15 minutes**

---

## Step 1: Create Empty Jobs

Create the following **four freestyle jobs** (no build steps required):

* `Accounting-Build`
* `Accounting-Deploy`
* `Engineering-Build`
* `Engineering-Deploy`

Steps:

1. Go to **Dashboard → New Item**
2. Select **Freestyle project**
3. Enter the job name
4. Click **OK → Save**

<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st71.png" width="500"> </div>

---

## Step 2: Create Views Based on Job Type

### View 1: Build

1. Click **+** next to Views → **Create a view**
2. View name: `Build`
3. View type: **List View**
4. Enable **Use a regular expression to include jobs into the view**
5. Regular expression:

   ```
   .*Build.*
   ```
6. Enable **Recurse in subfolders**
7. Save the view

<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st72.png" width="300"> <img src="/cicd/assets/jenkinsImg/st73.png" width="300"></div>

---

### View 2: Deploy

1. Create another view
2. View name: `Deploy`
3. View type: **List View**
4. Enable **Use a regular expression to include jobs into the view**
5. Regular expression:

   ```
   .*Deploy.*
   ```
6. Enable **Recurse in subfolders**
7. Save the view

<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st74.png" width="300"> <img src="/cicd/assets/jenkinsImg/st75.png" width="300"></div>

<br>

<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st76.png" width="300"> <img src="/cicd/assets/jenkinsImg/st77.png" width="300"></div>

---

## Step 3: Create a New Job

Create a new freestyle job:

* **Job name:** `Engineering-Build-UI`

### Verification

* The job automatically appears in the **Build** view
* This confirms the regular expression is working correctly


<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st78.png" width="300"> <img src="/cicd/assets/jenkinsImg/st79.png" width="300"></div>

---

## Step 4: Create Folders by Team

### Create Folders

Create the following folders:

* `Engineering`
* `Accounting`

Steps:

1. Click **New Item**
2. Select **Folder**
3. Enter the folder name
4. Click **OK → Save**

<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st80.png" width="300" height="300"> <img src="/cicd/assets/jenkinsImg/st81.png" width="350"> </div>
<br>
<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st82.png" width="300" height="300"> <img src="/cicd/assets/jenkinsImg/st83.png" width="350" height="300"> <img src="/cicd/assets/jenkinsImg/st84.png" width="300" height="300"> </div>

---

### Move Jobs into Folders

Move jobs based on their team name:

#### Engineering Folder

* `Engineering-Build`
* `Engineering-Deploy`
* `Engineering-Build-UI`

#### Accounting Folder

* `Accounting-Build`
* `Accounting-Deploy`

> Use **Move** from the job menu or drag-and-drop (if enabled).

<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st85.png" width="300" height="300"> <img src="/cicd/assets/jenkinsImg/st86.png" width="350" height="300"> <img src="/cicd/assets/jenkinsImg/st87.png" width="300" height="300"> </div>
<br>
<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st88.png" width="300" height="300"> </div>

---

### Verification

* Jobs remain visible in **Build** and **Deploy** views
* Views work correctly across folders due to **recursive search**
<div style="display:flex; gap:10px;"> <img src="/cicd/assets/jenkinsImg/st89.png" width="300" height="300"> <img src="/cicd/assets/jenkinsImg/st90.png" width="300" height="300"> </div>

---

## Step 5: Use the Command Palette

The Command Palette allows fast navigation across Jenkins.

### Open Command Palette

* Press:

  * **Ctrl + K** (Windows / Linux)
  * **Cmd + K** (macOS)

---

### Navigation Tasks

1. **Open the Engineering-Build job**

   * Type: `Engineering-Build`
   * Select and open the job

2. **Navigate directly to the Accounting folder**

   * Type: `Accounting`
   * Select the folder

---

## Result

✔ Jenkins jobs are organized by **team folders**

✔ Views dynamically group jobs by **job type**

✔ Jobs remain discoverable after relocation

✔ Command Palette enables fast navigation

✔ Scalable structure for growing teams

---

## Final Folder Structure

```
Jenkins
├── Engineering
│   ├── Engineering-Build
│   ├── Engineering-Deploy
│   └── Engineering-Build-UI
└── Accounting
    ├── Accounting-Build
    └── Accounting-Deploy
```

---
<br><br>

[Return to course](/cicd/jenkins/jenkins.md)

