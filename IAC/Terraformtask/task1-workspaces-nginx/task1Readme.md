
# TASK 1 Terraform Docker Nginx — Workspace Based Setup


## 🎯 Goal
Use **Terraform workspaces** to run the same infrastructure code for multiple environments (`dev`, `prod`) using Docker (no AWS required).

Each workspace runs:
- One Nginx container
- On a different localhost port
- With isolated Terraform state

---

## 📁 Project Structure

```
terraform-docker-nginx/
├── main.tf
├── modules/
│   └── nginx/
│       ├── main.tf
|       |── outputs.tf
│       └── variables.tf

```

---



## 1️⃣ `main.tf` (Root Module)

### What this file does

This is the **entry point** of the Terraform project.

It is responsible for:

* Declaring **which provider Terraform must use** (Docker)
* Configuring the provider so Terraform can talk to Docker
* Defining **environment-specific logic** using workspaces
* Calling the Nginx module

### Key responsibilities

* Tells Terraform:
  *“Use the `kreuzwerker/docker` provider, not HashiCorp’s.”*
* Defines a **port mapping table** (`dev → 8080`, `prod → 9090`)
* Detects the **current workspace**
* Passes the correct port to the module
* Explicitly binds the Docker provider to the module

### Why it matters

This file controls **behavior per environment**.
Change workspace → behavior changes → code stays the same.

---

## 2️⃣ `modules/nginx/main.tf` (Nginx Infrastructure Logic)

### What this file does

This file defines **what infrastructure is created**.

In plain terms:

* Pulls the Nginx Docker image
* Runs an Nginx container
* Exposes it on a port provided by the root module

### Key responsibilities

* Declares that it depends on the Docker provider
* Creates Docker resources (image + container)
* Names the container using the workspace name to avoid clashes
* Keeps infrastructure logic **environment-agnostic**

### Why it matters

This file is **reusable**.
It does not care whether it’s `dev`, `prod`, or `test`.

That decision is made **outside**, in the root module.

---

## 3️⃣ `modules/nginx/variables.tf` (Module Interface)

### What this file does

This file defines **inputs** that the module expects.

Think of it like:

> Function parameters in programming.

### Key responsibilities

* Declares that the module needs an external port
* Enforces type safety (number)
* Prevents implicit or accidental values

### Why it matters

Without this:

* Terraform guesses values
* Provider resolution becomes ambiguous
* Errors become harder to debug

This file makes the module **safe and predictable**.

---

## 4️⃣ `.terraform/` (Generated – Not Written by You)

### What this directory does

This is Terraform’s **working directory**.

It stores:

* Downloaded providers
* Module copies
* Backend metadata

### Why it matters

* Must **never** be committed to Git
* Safe to delete anytime
* Recreated by `terraform init`

---

## 5️⃣ `.terraform.lock.hcl` (Provider Lock File)

### What this file does

Locks provider versions.

It ensures:

* Same provider version on every machine
* No surprise upgrades
* Reproducible builds

### Why it matters

This is Terraform’s equivalent of:

* `package-lock.json`
* `poetry.lock`
* `yarn.lock`

Delete only when debugging provider issues.

---

## 6️⃣ Terraform Workspaces (Not a File, But Critical)

### What workspaces do

Workspaces give:

* Separate **state files**
* Same **code**
* Different **runtime behavior**

### In this project

* `dev` → Nginx on port 8080
* `prod` → Nginx on port 9090
* Each workspace tracks its own container

### Why it matters

This is how teams:

* Isolate environments
* Avoid duplication
* Manage infra cleanly


---

## 🚀 Terraform Commands

### Clean previous state

```bash
rm -rf .terraform/ .terraform.lock.hcl
```

---

### Initialize Terraform

```bash
terraform init
```

---

### Create and deploy **dev** environment

```bash
terraform workspace new dev
terraform workspace select dev
terraform plan
terraform apply
```

---

### Create and deploy **prod** environment

```bash
terraform workspace new prod
terraform plan
terraform apply
```


<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/terraform-docker-nginx/Taskimg/1.png" width="400">  </div>


---

## ✅ Verification

Open in browser:

* **Dev environment**

  ```
  http://localhost:8080/
  ```


<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/terraform-docker-nginx/Taskimg/3.png" width="400">  </div>


* **Prod environment**

  ```
  http://localhost:9090/
  ```


<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/terraform-docker-nginx/Taskimg/2.png" width="400">  </div>


Each workspace:

* Uses the same code
* Has its own Terraform state
* Runs independently

---

## 🧠 Key Learnings

* Terraform workspaces isolate state, not code
* Same module can be reused for multiple environments
* `terraform.workspace` enables dynamic configuration
* Provider source must be explicitly defined in modules
* Docker is perfect for learning Terraform without cloud access

---

## 🧹 Cleanup (Optional)

```bash
terraform destroy
```

Run per workspace if needed:

```bash
terraform workspace select dev
terraform destroy

terraform workspace select prod
terraform destroy


terraform workspace select default
rm -rf .terraform .terraform.lock.hcl terraform.tfstate terraform.tfstate.d
```

---
---
