# Bitbucket Complete Guide – Simplified Notes & Tasks

> **Goal**: Understand Bitbucket from zero to pushing code confidently (theory + practical)

---

## 1. Introduction to Bitbucket

Modern software development needs:

* Version control (track changes)
* Collaboration (multiple developers)
* Project organization

**Bitbucket** is a cloud-based platform that hosts **Git repositories** and helps teams collaborate using:

* Repositories
* Branches & Pull Requests
* Jira integration

---

## 2. How Bitbucket Organizes Content

Bitbucket uses **three levels**:

### 2.1 Workspace

* Top-level container
* Holds projects and repositories
* Can be **public or private**
* Workspace name must be **globally unique**
* URL format:

  ```
  https://bitbucket.org/WORKSPACE_NAME
  ```

👉 *Think of a workspace as a company or personal account.*

---

### 2.2 Project

* Groups multiple repositories
* Can be public or private
* Applies common settings to repositories
* Project name must be unique **inside a workspace**

👉 *Think of a project as an application or product.*

---

### 2.3 Repository

* Contains actual files and full version history
* Central place for collaboration
* Can be public or private
* Repository name must be unique inside a workspace

👉 *Think of a repository as the codebase.*

---

## 3. Public vs Private Repositories

### Public Repository

* Anyone can **view** the code
* Only permitted users can **modify**
* Best for **open-source projects**

### Private Repository

* Hidden from the public
* Only invited users can access
* Used for **company code, sensitive logic, internal apps**

---

## 4. Adding Files Using Bitbucket Web UI

### Steps

1. Open repository
2. Select **Source**
3. Click **… (three dots)** → **Add file**
4. Enter file name and content
5. Select **Commit**
6. Add commit message (or accept default)

### Limitation

* Web UI is good for small changes
* Real development is done **locally**

---

## 5. SSH and Secure Authentication

### What is SSH?

* Secure Shell protocol
* Encrypts data and credentials
* Used by Git to connect securely to Bitbucket

---

### SSH Key Pair

An SSH key pair has:

* **Public key** → added to Bitbucket
* **Private key** → stored on your system (never share)

Git uses:

* Private key (local)
* Public key (Bitbucket)

To verify identity and permissions.

---

### SSH Key Locations in Bitbucket

* **Personal account** → best for individuals
* **Workspace** → good for teams
* **Project** → read-only access

---

### Generate SSH Key Pair

```bash
ssh-keygen -t ed25519 -C "my bitbucket key" -f ~/.ssh/bitbucket
```

Creates:

* `bitbucket` → private key
* `bitbucket.pub` → public key

ED25519 is fast and secure.

---

### SSH Client Configuration

File: `~/.ssh/config`

```text
Host bitbucket.org
  IdentityFile ~/.ssh/bitbucket
  User git
```

This ensures Git always uses the correct key.

---

### SSH Security Rules

* Never share private keys
* Never push keys to repositories
* Use separate keys for services

---

## 6. Cloning a Repository

### Why clone?

* Creates a local copy of remote repo
* Allows offline work
* Enables use of editors and tools

### Command

```bash
git clone <repository-ssh-url>
```

After cloning:

* Files
* Commit history
* Metadata

are available locally.

---

## 7. Basic Git Workflow (MOST IMPORTANT)

### Core Commands

* `git status` → shows current state (use often!)
* `git add` → stages files
* `git commit` → saves snapshot with message
* `git push` → uploads changes to Bitbucket

---

### Standard Workflow

```bash
git status
git add .
git commit -m "message"
git push
```

👉 **No push = Bitbucket doesn’t know your work**

---

## 8. Pushing Code to Remote Repository

### What happens when you push?

* Local commits are sent to Bitbucket
* Remote repository updates
* Commit appears in web UI

### Verification

* Check **Commits** tab
* Check **Source** tab
* Commit message confirms success

---

## 9. Practical Task – Complete Workflow

### Task Requirements

* Create a public workspace
* Create a project named **amazing**
* Create two repositories:

  * `team` → private
  * `community` → public

---

### Local Steps (for each repo)

```bash
git clone <repo-url>
cd <repo-name>
vim CONTRIBUTING.md
```

Add content:

```md
# CONTRIBUTING
```

Run Git workflow:

```bash
git status
git add .
git commit -m "repo is ready"
git push
```

---

### Final Verification

* File visible in Bitbucket
* Correct commit message shown
* Lock icon visible for private repo

---

## 10. Final Key Takeaways

* Workspace → Project → Repository
* Public = visible, Private = restricted
* SSH is mandatory for secure Git usage
* `git status` tells you what to do next
* Real developers work locally and push changes

---
