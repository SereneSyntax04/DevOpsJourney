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

