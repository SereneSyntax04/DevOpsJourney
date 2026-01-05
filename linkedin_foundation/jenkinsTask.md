
# Automate System Monitoring with Jenkins

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
  <img src="./assets/jenkinsImg/st19.png" alt="desktop running" width="500"/> 
</p>

---

## Step 2: Configure Build Trigger
Schedule the job to run once a day. Options include the following, among others:
- 0 0 * * *
- H H * * *
- @daily
- @midnight
<p align="center"> 
  <img src="./assets/jenkinsImg/st20.png" alt="desktop running" width="500"/> 
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
  <img src="./assets/jenkinsImg/st21.png" alt="desktop running" width="500"/> 
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
  <img src="./assets/jenkinsImg/st22.png" alt="desktop running" width="500"/> 
</p>

---

## Step 5: Verification

1. Click **Build Now**
2. Confirm build status is **SUCCESS**
3. Open **Console Output** to verify execution
4. Download `system-report.txt` from **Artifacts**

<p align="center"> 
  <img src="./assets/jenkinsImg/st23.png" alt="desktop running" width="500"/>  <br><br>
  <img src="./assets/jenkinsImg/st24.png" alt="desktop running" width="500"/>
</p>

---

## Result

The Jenkins job runs daily, collects system information, and archives the report for future reference.

---
<br><br>





# Use a Build Tool and Parameters (Jenkins)

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

### Maven Configuration

* Under **Maven installations**:

  * Name: `maven-3.9.9`
  * Enable **Install automatically**
  * Select the latest available Maven version

Save the configuration.

---

## Step 2: Create a Freestyle Project

* Go to **Dashboard → New Item**
* Select **Freestyle project**
* Project name: `java-calculator`
* Click **OK**

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

### String Parameters

1. **Name:** `NUMBER_1`

   * Default value: `10`

2. **Name:** `NUMBER_2`

   * Default value: `5`

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

---

## Step 5: Add Maven Build Step

Add build step:

**Invoke top-level Maven targets**

* **Maven Version:** `maven-3.9.9`
* **Goals:**

  ```
  clean test package
  ```

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

---

## Step 7: Configure Post-Build Actions

### Archive Artifacts

* **Files to archive:**

  ```
  **/target/calculator-1.0-SNAPSHOT.jar
  ```

### Publish JUnit Test Results

* **Test report XMLs:**

  ```
  **/target/surefire-reports/*.xml
  ```

---

## Step 8: Verify the Job

1. Click **Build with Parameters**
2. Choose an operation (e.g., `add`)
3. Keep default values or modify numbers
4. Run the build

### Verification Checklist

* Console Output shows parameter values
* Maven build completes successfully
* Calculator result is displayed
* JAR file appears under **Artifacts**
* Test results are published

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




# Create Folders and Views (Jenkins)

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

---

## Step 3: Create a New Job

Create a new freestyle job:

* **Job name:** `Engineering-Build-UI`

### Verification

* The job automatically appears in the **Build** view
* This confirms the regular expression is working correctly

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

---

### Verification

* Jobs remain visible in **Build** and **Deploy** views
* Views work correctly across folders due to **recursive search**

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

[Return to course](devops_foundation_jenkins.md)