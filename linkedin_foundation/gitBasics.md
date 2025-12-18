<h1 align='center'>Introduction to Git </h1>

Git is a **version control system** used by developers to track changes in code, collaborate with others, and safely manage project history.
Instead of overwriting files or passing zip folders, Git keeps a **timeline of changes**, so you can go back, compare, or fix mistakes anytime.

---

## 1. Version Control

**Version control** is a system that records changes to files over time.

**Why it matters:**

* You can **track who changed what and when**
* You can **rollback** to a previous working version
* Multiple people can work on the same project without chaos
* Prevents the classic `final_final_v3.zip` mess

👉 Example: If today’s code breaks, version control lets you go back to yesterday’s working code.

---

## 2. Git

**Git** is a **distributed version control system** created by **Linus Torvalds**.

**Key points:**

* Works **locally** (no internet required)
* Every developer has a **full copy of the project history**
* Fast, reliable, and industry standard
* Used with platforms like **GitHub, GitLab, Bitbucket**

👉 Git = tool
👉 GitHub = platform to host Git repositories online

---

## 3. Basic Git Terminology

* **Repository (Repo):**
  A project folder tracked by Git

* **Working Directory:**
  Where you create or edit files

* **Staging Area (Index):**
  A waiting area where selected changes are prepared for commit

* **Commit:**
  A snapshot of staged changes with a message

* **Branch:**
  A separate line of development (default is `main`)

* **HEAD:**
  Pointer to the current commit you’re on

👉 Think of Git like:

* Working directory = writing notes
* Staging = selecting pages to submit
* Commit = submitting the assignment

---

## 4. Basic Git Workflow (File Creation → Staging → Commit)

### Step 1: File Creation

You create or modify a file in your project folder.

```bash
touch app.py
```

### Step 2: Staging

You tell Git **which changes you want to save**.

```bash
git add app.py
```

### Step 3: Commit

You permanently record those changes with a message.

```bash
git commit -m "Add initial app file"
```

**Workflow Summary:**

```
Create/Edit File → Stage Changes → Commit Snapshot
```

👉 Nothing is saved in Git history until you **commit**.
👉 `git add` ≠ save forever, `git commit` = save forever.

---
<br>

<h1 align='center'> Commonly Used Git Commands</h1>

## Repository Setup

```bash
git init
```

Initializes a new Git repository in the current directory.

```bash
git clone <repo-url>
```

Creates a local copy of an existing remote repository.

---

## Checking Status & History

```bash
git status
```

Shows the current state of the working directory and staging area.

```bash
git log
```

Displays the full commit history.

```bash
git log --oneline
```

Shows a compact, one-line commit history (useful for exams).

---

## Staging & Committing

```bash
git add <file>
```

Stages a specific file.

```bash
git add .
```

Stages all modified files.

```bash
git commit -m "commit message"
```

Saves staged changes permanently to the repository.

---

## Branching

```bash
git branch
```

Lists all branches.

```bash
git branch <branch-name>
```

Creates a new branch.

```bash
git checkout <branch-name>
```

Switches to another branch.

```bash
git checkout -b <branch-name>
```

Creates and switches to a new branch in one step.

---

## Working with Remote Repositories

```bash
git remote -v
```

Shows linked remote repositories.

```bash
git pull
```

Fetches and merges changes from the remote repository.

```bash
git push
```

Uploads local commits to the remote repository.

---

## Undo & Fix Commands

```bash
git restore <file>
```

Discards changes in the working directory.

```bash
git reset HEAD <file>
```

Unstages a file without deleting changes.

```bash
git revert <commit-id>
```

Creates a new commit that safely undoes a previous commit.

---

## Quick Memory Flow

```
Check  → git status
Stage  → git add
Save   → git commit
Sync   → git pull / git push
```

👉 Tip: Nothing is saved in Git history until you **commit**.
