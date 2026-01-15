# 🧩 Task 2 — Terraform Multi-Container App (Docker Networking Deep Dive)

This task demonstrates **how Terraform wires resources together** using references and how **Docker networking enables containers to talk to each other by name**.

This is **not** about running Nginx or Redis.
This is about understanding **Terraform’s dependency graph**.

---

## 🎯 Objective

Build a small multi-container setup using Terraform that includes:

* A **custom Docker network**
* A **Redis container** (internal only)
* An **Nginx container** (exposed to host)
* Container-to-container communication via **network + DNS**

---

## What Terraform does?

> Terraform does **NOT** execute code top-to-bottom.
> Terraform builds a **dependency graph** from references.

If Resource A **references** Resource B, Terraform guarantees:

* B is created **before** A
* Without you specifying any order

---

## 📁 Project Layout

```
terraform-multi-container/
└── README.md   ← (this file contains everything)
```

---

## 🧱 Terraform Code 

- [main.tf](/IAC/Terraformtask/task2-multi-container/main.tf)

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

* Tells Terraform:

  * “I will talk to Docker”
  * “Download the Docker provider”
* Terraform itself **does nothing** without providers

```hcl
provider "docker" {}
```

* Initializes Docker provider
* Uses local Docker daemon

---

### 2️⃣ Docker Network

```hcl
resource "docker_network" "app_net" {
  name = "app_network"
}
```

What this does **in reality**:

* Creates a Docker bridge network
* Enables:

  * Container isolation
  * Internal DNS resolution

Key concept:

> Docker provides **DNS by container name** inside a network

---

### 3️⃣ Redis Container (Internal Service)

```hcl
resource "docker_container" "redis" {
  name  = "redis"
  image = "redis:7"
```

* Container name = `redis`
* This becomes the **DNS hostname**

```hcl
networks_advanced {
  name = docker_network.app_net.name
}
```

🔥 **This line is critical**

It does TWO things:

1. Attaches Redis to the network
2. Creates an **implicit dependency**

Terraform graph becomes:

```
docker_network.app_net → docker_container.redis
```

Redis:

* Has NO exposed ports
* Is reachable **only inside the network**

---

### 4️⃣ Nginx Container (External Entry Point)

```hcl
resource "docker_container" "nginx" {
  name  = "nginx"
  image = "nginx:latest"
```

```hcl
ports {
  internal = 80
  external = 8080
}
```

Meaning:

* Container listens on port 80
* Host maps it to port 8080

Traffic flow:

```
Browser → localhost:8080 → nginx:80
```

```hcl
networks_advanced {
  name = docker_network.app_net.name
}
```

This creates another dependency:

```
docker_network.app_net → docker_container.nginx
```

---

## 🧩 Final Dependency Graph 

Terraform automatically builds this:

```
app_network
 ├── redis
 └── nginx
```

No `depends_on` required.

---

# ▶️ Execution Steps (Commands)

## 1️⃣ Initialize Terraform

```bash
terraform init
```
<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task2-multi-container/Taskimg/init.png" width="400">  </div>

* Downloads Docker provider
* Prepares working directory

---

## 2️⃣ Validate Configuration

```bash
terraform validate
```
<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task2-multi-container/Taskimg/validate.png" width="400">  </div>

* Checks syntax
* Verifies references
* Confirms graph is valid

---

## 3️⃣ View Execution Plan

```bash
terraform plan
```
<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task2-multi-container/Taskimg/plan.png" width="400">  </div>

* Shows what will be created
* No changes applied yet

---

## 4️⃣ Apply Configuration

```bash
terraform apply --auto-approve
```
<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task2-multi-container/Taskimg/apply.png" width="400">  </div>

Creates:

* Docker network
* Redis container
* Nginx container

---

## 🔍 Verification (Proving Networking Works)

### Check running containers

```bash
docker ps
```
<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task2-multi-container/Taskimg/ps.png" width="400">  </div>

Expected:

* nginx
* redis

---

### Enter nginx container

```bash
docker exec -it nginx sh
```

#### Test Redis connectivity

```sh
curl http://redis:6379
```

Output:

```text
curl: (52) Empty reply from server
```

<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task2-multi-container/Taskimg/exec.png" width="400">  </div>


## ✅ Why This Output Means SUCCESS

* `redis` hostname resolved → DNS works
* TCP connection opened → Network works
* Redis rejected HTTP → Expected behavior

If networking was broken, errors would be:

* `Could not resolve host`
* `Connection refused`

You saw neither.

---

# 🧹 Cleanup (Mandatory)

### Preferred: Terraform-managed cleanup

```bash
terraform destroy --auto-approve
```

<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task2-multi-container/Taskimg/destroy.png" width="400">  </div>

---

### Manual cleanup (if state is broken)

```bash
docker rm -f nginx redis
docker network rm app_network
docker rmi -f <img_name>
```

<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task2-multi-container/Taskimg/rmi.png" width="400">  </div>

---

## 🧠 What This Task Teaches (Important)

* Terraform builds **relationships**, not steps
* Resource references create **implicit ordering**
* Docker networks provide **service discovery**
* Errors can indicate **successful connectivity**
* Providers perform real actions, Terraform coordinates

---
