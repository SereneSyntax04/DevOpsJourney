
# 🧩 Task 3 — Terraform Data Sources (READ vs CREATE)

This task demonstrates the **difference between Terraform resources and data sources**.

This is NOT about running Docker.
This is about understanding **ownership, lifecycle, and state**.


---

## 🎯 Objective

Learn the difference between:

Terraform **creating** infrastructure  
vs  
Terraform **reading existing infrastructure**

By building:

- A Docker container (Terraform-owned)
- Using a Docker image (NOT Terraform-owned)
- Reading image metadata via a data source
- Outputting image information

---

### 🧠 Core Idea (Read This Carefully)

Terraform has TWO ways to reference things:

- `resource` → Terraform **creates and owns**
- `data` → Terraform **reads but does NOT own**

Terraform does **NOT** manage what it does not create.

---

## 📁 Project Layout

terraform-data-source/
└── README.md   ← (this file contains everything)

---

## 🧱 Terraform Code

[main.tf](/IAC/Terraformtask/task3-data-sources/main.tf)

---

### 1️⃣ Provider Configuration

```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}
```

What this tells Terraform:

* “I want to talk to Docker”
* “Download the Docker provider”
* Terraform itself does nothing without providers

```hcl
provider "docker" {}
```

Initializes Docker provider
Uses local Docker daemon



### 2️⃣ Data Source — Docker Image (READ ONLY)

```hcl
data "docker_image" "nginx" {
  name = "nginx:latest"
}
```

🔥 This is the MOST IMPORTANT PART of this task

What this does:

* Terraform does NOT pull the image
* Terraform does NOT manage the image
* Terraform only **reads metadata** about an existing image

Terraform expectation:

> “Docker must already be able to access this image”

If the image does not exist or cannot be pulled → Terraform fails.



### 3️⃣ Docker Container (CREATE + OWNED)

```hcl
resource "docker_container" "nginx" {
  name  = "nginx-data-demo"
  image = data.docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8083
  }
}
```

Key observations:

* Container is a **resource**
* Terraform creates it
* Terraform owns its lifecycle
* Terraform will destroy it

The image value comes from:

```hcl
data.docker_image.nginx.image_id
```

This creates an **implicit dependency**:

```
data.docker_image.nginx → docker_container.nginx
```

Terraform guarantees:

* Image data is read BEFORE container is created

---

[outputs.tf](/IAC/Terraformtask/task3-data-sources/outputs.tf)

## Outputs — Proving Data Source Usage

```hcl
output "nginx_image_name" {
  value = data.docker_image.nginx.name
}

output "nginx_image_digest" {
  value = data.docker_image.nginx.repo_digest
}

output "container_id" {
  value = docker_container.nginx.id
}
```

Outputs demonstrate:

* Interpolation from data sources
* Interpolation from resources
* Data can feed both resources and outputs

---

## 🧩 Terraform Dependency Graph

Terraform automatically builds:

```
docker_image (data)
        ↓
docker_container (resource)
```

Important distinction:

* Data sources do NOT appear in state like resources
* Terraform does not track lifecycle for data

---

# Got it. This is a **good refinement** — you’re turning Task 3 from a happy-path demo into a **truthful learning exercise**. That’s how seniors write docs.

Below is your **updated Execution Steps section**, rewritten cleanly, same tone, but now **explicitly showing the failure → fix → success flow**.

You can **replace only this section** in your README.

---

## ▶️ Execution Steps (Including Failure Case)

### 1️⃣ Initialize Terraform

```bash
terraform init
```
<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task3-data-sources/Taskimg/init.png" width="400">  </div>

Downloads Docker provider
Prepares working directory

---

### 2️⃣ Validate Configuration

```bash
terraform validate
```
<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task3-data-sources/Taskimg/validate.png" width="400">  </div>

Checks syntax
Validates references
Confirms dependency graph

---

### 3️⃣ Attempt Plan WITHOUT Image Present (Expected Failure)

Ensure the image does **NOT** exist locally:

```bash
docker rmi nginx:latest
```

Now run:

```bash
terraform plan
```
<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task3-data-sources/Taskimg/planFail.png" width="400">  </div>

Expected result:

```text
Error: did not find docker image 'nginx:latest'
```

✅ This failure is **intentional and correct**

Terraform is trying to **read existing data**.
Since the image does not exist, Terraform **fails fast**.

This proves:

* Data sources do NOT create infrastructure
* Terraform does NOT manage image lifecycle

---

### 4️⃣ Manually Pull Image (Out-of-Band Action)

Pull the image using Docker directly:

```bash
docker pull nginx:latest
```
<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task3-data-sources/Taskimg/pull.png" width="400">  </div>

This action is **outside Terraform**.

Terraform does not record this in state.

---

### 5️⃣ View Execution Plan (Now Succeeds)

```bash
terraform plan
```
<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task3-data-sources/Taskimg/planSuccess.png" width="400">  </div>

Terraform now shows:

* Reading `data.docker_image.nginx`
* Creating `docker_container.nginx`

No changes applied yet.

---

### 6️⃣ Apply Configuration

```bash
terraform apply --auto-approve
```
<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task3-data-sources/Taskimg/apply.png" width="400">  </div>

Creates:

* Nginx container

Reads:

* Docker image metadata

---

## 🔍 Verification

Check running containers:

```bash
docker ps
```
<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task3-data-sources/Taskimg/ps.png" width="500">  </div>

Expected:

* `nginx-data-demo`

Open browser:

```text
http://localhost:8083
```
<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task3-data-sources/Taskimg/localhost.png" width="400">  </div>

Nginx welcome page should load.

---

## 🧠 What This Task Teaches (Critical)

* Terraform does NOT execute top-to-bottom
* Terraform builds a dependency graph
* `data` ≠ `resource`
* Data sources are READ-only
* Terraform does NOT own data lifecycle
* Missing data causes **hard failures**
* Resources are owned and destroyed by Terraform

---

## ❌ Common Wrong Assumptions

* “Terraform pulled the image” → ❌
* “Terraform manages the image” → ❌
* “Data sources are safe forever” → ❌

---

## ✅ Correct Model

* Docker pulls the image
* Terraform reads metadata
* Terraform creates container
* Terraform owns container
* Terraform does NOT own image

---


## 🧹 Cleanup

Terraform-managed cleanup (preferred):

```bash
terraform destroy --auto-approve
```

Manual cleanup (only if state is broken):

```bash
docker rm -f nginx-data-demo
docker rmi nginx:latest
rm -rf .terraform .terraform.lock.hcl terraform.tfstate terraform.tfstate.backup 
```

---

🚀 Why This Task Matters

This exact concept is used later with:

* `data "aws_ami"`
* `data "aws_vpc"`
* `data "aws_subnet"`
* `data "aws_iam_role"`

If you don’t understand this now, AWS Terraform will feel confusing later.

This task fixes that permanently.




---
---

<br>











