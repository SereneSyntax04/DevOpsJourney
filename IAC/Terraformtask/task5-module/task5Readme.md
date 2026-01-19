# 🧩 TASK 7 — Module Composition (Advanced but Gold)

**Theme:** *Small, reusable modules + dumb root module.*

If you remember **one rule** from this task, remember this:

> **Modules create things. Root wires them. Root stays boring.**

---

## 🎯 What you’ll build

* **Network module**

  * Creates a bridge network
* **App module**

  * Runs Nginx container
* **Root module**

  * Connects both
  * Passes outputs → inputs

No hardcoding. Everything flows.

---

## 📁 Final Project Structure (REAL-WORLD STYLE)

```
terraform-module-composition/
├── main.tf                # root wiring only
├── variables.tf           # root inputs
├── outputs.tf             # root outputs
│
├── modules/
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── app/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
```

---

## Execution Steps (Start → Working Nginx)

### ✅ Prerequisites (don’t skip this)

Be honest with yourself before typing commands:

* Docker **must be running**

  ```bash
  docker ps
  ```

  If this fails → stop → start Docker.

* Terraform installed

  ```bash
  terraform version
  ```

---

## 1️⃣ Go to **root folder**

The folder that contains:

```
main.tf
variables.tf
outputs.tf
modules/
```

```bash
cd terraform-module-composition
```

Root only. Always.

---

## 2️⃣ Initialize Terraform

This:

* downloads providers
* prepares module cache
* creates `.terraform/`

```bash
terraform init
```

✔️ You should see:
`Terraform has been successfully initialized`

If this fails → provider / syntax issue.

<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task5-module/Taskimg/init.png" width="400"> </div>

---

## 3️⃣ Validate configuration (cheap safety check)

```bash
terraform validate
```

If this errors:

* variable mismatch
* typo in module output name
* missing input

Fix before moving on.

<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task5-module/Taskimg/validate.png" width="400"> </div>

---

## 4️⃣ See what Terraform plans to do

Now we pass **real input**.

```bash
terraform plan -var="host_port=8080" -var="env=dev"
```

You should see:

* 1 docker_network
* 1 docker_container

<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task5-module/Taskimg/plana.png" width="400"> <img src="/IAC/Terraformtask/task5-module/Taskimg/planb.png" width="400"> <img src="/IAC/Terraformtask/task5-module/Taskimg/planc.png" width="400"></div>

---

## 5️⃣ Apply (create infra)

```bash
terraform apply -var="host_port=8080" -var="env=dev"
```

Type:

```
yes
```

Terraform will:

* create network → `dev-network`
* create container → `dev-nginx`
* attach container to network

<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task5-module/Taskimg/apply.png" width="400"> </div>

---

## 6️⃣ Verify (don’t trust blindly)

### Check Docker

```bash
docker ps
docker network ls
```

You should see:

* container: `dev-nginx`
* network: `dev-network`

<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task5-module/Taskimg/verifyContainer.png" width="400"> <img src="/IAC/Terraformtask/task5-module/Taskimg/verifyNetwork.png" width="400"></div>

---

### Open Nginx in browser

```
http://localhost:8080
```

If this doesn’t load:

* Docker not running
* port already in use
* container failed

<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task5-module/Taskimg/localhost.png" width="400"> </div>

---

## 7️⃣ Check Terraform outputs

```bash
terraform output
```

Expected:

```
nginx_container = "dev-nginx"
```

This confirms module output wiring works.

<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task5-module/Taskimg/output.png" width="400"> </div>

---

## 8️⃣ Destroy (engineers clean up)

Always clean infra you created.

```bash
terraform destroy -var="host_port=8080" -var="env=dev"
rm -rf .terraform .terraform.lock.hcl  terraform.tfstate terraform.tfstate.backup
```

Type:

```
yes
```

<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task5-module/Taskimg/destroy.png" width="400"> </div>


---

## ⚠️ Common Execution Failures (read this)

### ❌ “provider docker not found”

→ You didn’t run `terraform init`

### ❌ “network not found”

→ App module ran before network
(usually means wrong output reference)

### ❌ Port already in use

→ Change port

```bash
-var="host_port=8081"
```

---
---


