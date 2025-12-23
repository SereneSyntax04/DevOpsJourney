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

## Check Git username and email
To check global config (most common)

```bash
git config --global user.name
git config --global user.email
```

To see everything Git has configured
```bash
git config --list
```

## Repository Setup

1. Initializes a new Git repository in the current directory.
```bash
git init
```

2. Creates a local copy of an existing remote repository.
```bash
git clone <repo-url>
```


---

## Checking Status & History

1. Shows the current state of the working directory and staging area.
```bash
git status
```


2. Displays the full commit history.
```bash
git log
```

3. Shows a compact, one-line commit history (useful for exams).
```bash
git log --oneline
```


---

## Staging & Committing

1. Stages a specific file.
```bash
git add <file>
```


2. Stages all modified files.
```bash
git add .
```


3. Saves staged changes permanently to the repository.
```bash
git commit -m "commit message"
```

---

## Branching

1. Lists all branches.
```bash
git branch
```

2. Creates a new branch.
```bash
git branch <branch-name>
```


3. Switches to another branch.
```bash
git checkout <branch-name>
```

4. Creates and switches to a new branch in one step.
```bash
git checkout -b <branch-name>
```



---

## Working with Remote Repositories

1. Shows linked remote repositories.
```bash
git remote -v
```


2. Fetches and merges changes from the remote repository.
```bash
git pull
```


3. Uploads local commits to the remote repository.
```bash
git push
```



---

## Undo & Fix Commands

1. Discards changes in the working directory.
```bash
git restore <file>
```


2. Unstages a file without deleting changes.
```bash
git reset HEAD <file>
```


3. Creates a new commit that safely undoes a previous commit.
```bash
git revert <commit-id>
```



---

## Quick Memory Flow

```
Check  → git status
Stage  → git add
Save   → git commit
Sync   → git pull / git push
```

👉 Tip: Nothing is saved in Git history until you **commit**.


---


<h1 align='center'> HTTPS vs SSH (Git Authentication) </h1>

When connecting a **local Git repository** to a **remote Git hosting service** (like GitHub or Bitbucket), there are two common authentication methods:

* **HTTPS**
* **SSH**

Both are secure, but they differ in setup, usability, and security model.

---

## SSH Authentication

**SSH (Secure Shell)** uses **public-key cryptography** for authentication.

### Key Features

* Uses **SSH keys** (public + private key pair)
* More **secure** than HTTPS
* No need to enter credentials repeatedly after setup
* Ideal for frequent Git users and professionals

### Advantages

* Strong authentication using cryptographic keys
* No repeated login prompts
* Preferred for long-term development work

### Disadvantages

* Initial setup is **more complex**
* Requires understanding SSH keys
* May be blocked in **restricted networks or firewalls**

---

## HTTPS Authentication

**HTTPS** uses standard web-based authentication to communicate with Git hosting services.

### Key Features

* Easier to set up than SSH
* Works well in **restricted or corporate networks**
* Compatible with most firewalls

### GitHub Note (Important)

* GitHub **does not allow passwords** for Git operations
* A **Personal Access Token (PAT)** must be used **instead of a password**

### Advantages

* Beginner-friendly setup
* Works reliably behind firewalls
* Suitable for most users

### Disadvantages

* Requires authentication more frequently
* Slightly less secure compared to SSH
* Token management required

---

## Avoiding Repeated Login (HTTPS)

You can store credentials securely using:

* **Keychain Access** (macOS)
* **Credential Manager** (Windows)

This prevents entering the token every time.

---

## Generating a GitHub Personal Access Token (Classic)

### Steps

1. Sign in to GitHub
2. Go to **Profile → Settings**
3. Click **Developer settings**
4. Select **Personal access tokens → Tokens (classic)**
5. Click **Generate new token (classic)**
6. Add a meaningful **Note** (e.g., Git CLI access)
7. Set an **expiration date** (recommended: 90 days)
8. Select required **scopes** (at least `repo`)
9. Click **Generate token**

⚠️ Copy the token immediately — it cannot be viewed again.

---

<br><br>

[Click here to redirect to INDEX](../README.md) 