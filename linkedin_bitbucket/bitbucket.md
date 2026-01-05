
# Chapter 01 – Bitbucket Basics & Repositories

## 01_01 Introduction to Bitbucket

Modern software development requires tools that:
- Track code changes
- Enable collaboration
- Manage multiple projects efficiently

**Bitbucket** is a cloud-based platform that:
- Hosts Git-based repositories
- Enables collaboration using branches and pull requests
- Integrates with Jira for project management

By using Bitbucket, teams can manage code, workflows, and projects in one place.

---

## 01_02 Bitbucket Content Organization

Bitbucket organizes content using **three main components**:

### 1. Workspace
- Top-level container
- Holds projects and repositories
- Can be **public or private**
- Workspace name must be **globally unique**
- URL format:
```bash
[https://bitbucket.org/WORKSPACE_NAME](https://bitbucket.org/WORKSPACE_NAME)
```

👉 Think of a workspace as a **company or team account**.

---

### 2. Project
- Groups multiple repositories
- Can be public or private
- Applies common settings to repositories
- Project name must be unique **inside a workspace**

👉 Think of a project as an **application or product**.

---

### 3. Repository
- Contains files and full revision history
- Central location for collaboration
- Can be public or private
- Repository name must be unique inside a workspace

👉 Think of a repository as the **actual codebase**.

---

### Summary
- Solo developer → One workspace, one project, multiple repositories
- Team environment → Workspaces help manage access and permissions

---

## 01_03 Public and Private Repositories

Repositories can be **public** or **private**.

### Public Repositories
- Visible to anyone on the internet
- Only permitted users can make changes
- Ideal for **open-source projects**

### Private Repositories
- Hidden from the public
- Only invited users can access
- Used for **company code, sensitive logic, private apps**

---

## 01_04 Add Files Using Bitbucket Web UI

### Steps
1. Open repository
2. Select **Source**
3. Click **… (three dots)** → **Add file**
4. Enter file name and content
5. Select **Commit**
6. Add commit message (or accept default)

### Notes
- Bitbucket detects file type automatically
- Web UI is suitable for **small changes only**
- Real development is better done locally

---

## 01_05 SSH Authentication

### What is SSH?
- Secure Shell protocol
- Encrypts credentials and data
- Used by Git for secure communication

---

### SSH Key Pair
An SSH key pair consists of:
- **Public key** → Added to Bitbucket
- **Private key** → Stored locally (never share)

Authentication works using:
- Local Git client → Private key
- Bitbucket → Public key

---

### SSH Key Locations in Bitbucket

| Location          | Use Case |
|------------------|----------|
| Personal account | Best for individuals |
| Workspace        | Team access |
| Project          | Read-only access |

---

### Generate SSH Key

```bash
ssh-keygen -t ed25519 -C "my bitbucket key" -f ~/.ssh/bitbucket
````

Creates:

* `bitbucket` → private key
* `bitbucket.pub` → public key

ED25519 is a public-key algorithm used for SSH key generation. It is known for being faster and more secure than the older RSA algorithm, especially at shorter key lengths.

---

### SSH Client Configuration

File: `~/.ssh/config`

```text
Host bitbucket.org
  IdentityFile ~/.ssh/bitbucket
  User git
```

Ensures Git always uses the correct key.

---

### SSH Security Rules

* Never share private keys
* Never commit keys to repositories
* Use dedicated keys for services

---

## 01_06 Clone a Repository

### Why Clone?

* Creates a local copy of a remote repository
* Enables offline work
* Allows use of editors and tools

### Command

```bash
git clone <repository-ssh-url>
```

```bash
git clone git@bitbucket.org/WORKSPACE_NAME/REPO_NAME.git
```
This is the SSH URL of the repository you want to clone. It consists of:

1. git@bitbucket.org: The username and domain specifying that you're connecting to Bitbucket over SSH.
2. WORKSPACE_NAME: This should be replaced with the name of your Bitbucket workspace where the repository resides.
3. REPO_NAME: This should be replaced with the name of the specific repository you want to clone.

After cloning:

* Files
* Commit history
* Metadata
  are available locally.

---

## 01_07 Git Workflow (VERY IMPORTANT)

### Core Commands

* `git status` → Check repository state
* `git add` → Stage files
* `git commit` → Save snapshot
* `git push` → Upload changes

### Standard Workflow

```bash
git status
git add .
git commit -m "message"
git push
```

👉 No push = Bitbucket doesn’t know your work.

---

## 01_08 Challenge – Create Repositories and Push Code

### Requirements

* Public workspace
* Project named **amazing**
* Repositories:

  * `team` → private
  * `community` → public

### Local Steps (for each repo)

```bash
git clone <repo-url>
cd <repo-name>
vim CONTRIBUTING.md
```

```md
# CONTRIBUTING
```

```bash
git status
git add .
git commit -m "repo is ready"
git push
```

---
<br>

# Chapter 02 – Branches and Pull Requests

## 02_01 Branches

### What is a Branch?
- A branch points to a specific commit
- Allows isolated work on new features
- Prevents breaking the main codebase
- Enables parallel work by multiple developers

---

### Branch Workflow Concept
- Main branch contains stable code
- Feature branch created from main
- New commits added to feature branch
- Feature branch merged back to main

### Merge Commit
- Created when two branches are merged
- Records branch history

---

### Branch Naming Conventions

Format:

```bash
prefix/branch-name
```

Common prefixes:
- feature/
- bugfix/
- hotfix/
- release/

Example:

```bash
feature/login-page
```

---

## 02_02 Push Code to a Branch

### Common Commands

| Command | Purpose |
|------|--------|
| `git pull` | Download latest changes |
| `git checkout BRANCH` | Switch branches |
| `git branch` | List branches |

---

## 02_03 Pull Requests (PR)

### What is a Pull Request?
- Request to merge one branch into another
- Abbreviated as **PR**
- Used for review and approval

Pull Requests support:
- Collaboration
- Code review
- Feedback
- Code quality

---

### Pull Request Workflow
1. Create branch
2. Add and commit changes
3. Create pull request
4. Review and approve
5. Merge into main

---

### Merge Conflicts
- Occur when same code is modified in multiple branches
- Git cannot decide automatically
- Must be resolved manually

👉 Merge conflicts are normal.

---

## 02_04 Challenge – Create and Merge a Pull Request

### Tasks
- Use **community** repository
- Create branch:
```bash
feature/pull-request-demo
```
- Update `CONTRIBUTING.md`
- Commit changes
- Create PR (do not auto-create)
- Merge PR into main


---
<br>



# Chapter 03 – Manage Projects with Jira and Bitbucket

## 03_01 Manage Projects with Jira and Bitbucket

### What is Jira?
Jira is a **project management tool** used in software development to:
- Track work
- Organize tasks
- Monitor progress

It supports popular methodologies like:
- Agile
- Scrum
- Kanban

### Jira Work Items
Work in Jira is divided into small units such as:
- Issues
- Tasks
- Stories

These units help teams break big projects into **manageable pieces**.

### Jira Boards and Task Status
Tasks move across a board through different stages:

- **To Do** → Work not started  
- **In Progress** → Work ongoing  
- **Done** → Work completed  

(Simple projects usually use these three states.)

### Why Integrate Jira with Bitbucket?
Since both are Atlassian products, they integrate smoothly.

Integration benefits:
- Links code changes directly to Jira issues
- Improves communication between developers and managers
- Gives real-time project visibility

### Real-World Workflow Example
1. Project manager creates an issue in Jira.
2. Developer creates a **branch from the Jira issue**.
3. Issue automatically moves from **To Do → In Progress**.
4. Developer pushes code and creates a Pull Request.
5. Team reviews and merges the PR.
6. Issue automatically moves to **Done**.

👉 Result: No manual tracking, everything stays in sync.

---

## 03_02 Connect Jira to Bitbucket

### Steps to Connect Jira with Bitbucket

1. Create an account in **Jira Cloud**  
   - Hosted by Atlassian
   - No server or maintenance required

2. Create a **Jira Project**
   - Choose a template (Kanban recommended for beginners)

3. Connect Jira to Bitbucket
   - Select workspace
   - Connect one or more repositories

### Key Points
- One Jira project can connect to **multiple repositories**
- Helps track work across different codebases
- Once connected, Jira issues appear inside Bitbucket

---

## 03_03 Automate Issue Updates

### What is Jira Automation?
Jira Automation keeps Jira and Bitbucket **synchronized automatically**.

Benefits:
- Reflects real-time development status
- Developers stay in Bitbucket
- Managers track progress in Jira

### Automation Rules
Automation works using:
- **Triggers** → Events that start automation
- **Actions** → What Jira does after trigger

#### Common Triggers
- Branch creation
- Commit creation
- Pull Request merge

### Useful Automation Rules
Jira provides ready-made templates:

1. **When a branch is created**
   - If issue is in *To Do*
   - Move issue to *In Progress*

2. **When a Pull Request is merged**
   - If issue is not Done
   - Move issue to *Done*

👉 Just enable the rules — no coding required.

---

## 03_04 Create an Issue and Link to a Bitbucket Branch

### Steps Performed
1. Create a new Jira issue.
2. Assign the issue to yourself.
3. Click **Create Branch** from the issue.
4. Select:
   - Repository
   - Branch type (feature)
   - Base branch (main)

### What Happens Automatically?
- Branch is created in Bitbucket.
- Jira issue moves from **To Do → In Progress**.
- Automation logs confirm the rule execution.
- Issue appears in the correct board column.

---

## 03_05 Update and Close Issues from Bitbucket

### Updating Code
1. Switch to the feature branch in Bitbucket.
2. Make a code change.
3. Commit the change.

### Creating a Pull Request
1. Create PR from feature → main.
2. Add meaningful title and description.
3. Enable option to delete branch after merge.

### Jira Updates
- Jira shows PR creation inside the issue.
- Managers can track progress without opening Bitbucket.

### Closing the Issue
1. Merge the Pull Request.
2. Jira automatically moves issue to **Done**.
3. Automation confirms PR merge and issue completion.

---

## Challenge: Trigger Jira Automation from Bitbucket

### Task Objective
Set up Jira and Bitbucket to demonstrate:
- Issue tracking
- Branch linking
- Automation using PRs

### Challenge Steps
1. Create a Jira project.
2. Connect existing Bitbucket repositories.
3. Add automation rules:
   - Branch created → In Progress
   - PR merged → Done
4. Create a Jira issue.
5. Create a feature branch from the issue.
6. Create and merge a Pull Request.

---

## Solution Summary

### Final Setup Verification
- Jira project created successfully.
- Multiple repositories connected.
- Automation rules enabled and active.

### Proof of Automation
- Issue moved:
  - To Do → In Progress (on branch creation)
  - In Progress → Done (on PR merge)
- Automation logs confirm rule execution.

### Final Outcome
Bitbucket actions directly updated Jira issues without manual intervention.

👉 **Automation + integration = accurate tracking and better teamwork**

---

## Key Takeaway
Jira + Bitbucket integration creates a **single source of truth** for:
- Code
- Tasks
- Progress
- Team collaboration

<br><br>

[Click here to redirect to INDEX](../README.md) 