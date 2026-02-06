
# 🧩 TASK 4 — Remote State (Still Local)

## Big picture 

Terraform **projects should not be copy-pasted** into each other.
They should **talk** using outputs — clean, explicit, versionable.

That’s what `terraform_remote_state` is for.

Think of it like this:

* **Project A** = “I create”
* **Project B** = “I consume”
* They are **independent**
* If Project B explodes → Project A stays untouched

That’s real-world infra.

---

## 🧠 What you’ll build

### Project A

* Creates a **Docker network**
* Exposes the network name + ID as outputs
* Has its own state file

### Project B

* Reads Project A’s state
* Uses that network to attach a container
* Never recreates the network

---

## 🅰️ Project A — Network Creator

### `project-a-network/main.tf`

```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "shared_net" {
  name = "shared_app_network"
}
```

### `project-a-network/outputs.tf`

```hcl
output "network_name" {
  value = docker_network.shared_net.name
}

output "network_id" {
  value = docker_network.shared_net.id
}
```

---

## 🅱️ Project B — State Consumer

This is where the magic happens.

### `project-b-app/main.tf`

```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

data "terraform_remote_state" "network" {
  backend = "local"

  config = {
    path = "../project-a-network/terraform.tfstate"
  }
}

resource "docker_container" "app" {
  name  = "app_container"
  image = "nginx:latest"

  networks_advanced {
    name = data.terraform_remote_state.network.outputs.network_name
  }

  ports {
    internal = 80
    external = 8085
  }
}
```

---


## 🔍 PHASE 0 — Non-negotiable prerequisite check

Before Terraform even enters the room, Docker must be alive.

### Run:

```bash
docker info
```

### If you see:

* ❌ error / cannot connect → **STOP** → Docker Desktop is not running
* ✅ long output → continue

---

## 🔥 PHASE 1 — Project A (Network) — CLEAN BOOT

### 1️⃣ Go to Project A

```bash
cd project-a-network
```

Confirm files:

```bash
ls
```

Must be:

```
main.tf
outputs.tf
```

<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task4-remote-state/Taskimg/projA.png" width="400">  <img src="/IAC/Terraformtask/task4-remote-state/Taskimg/projAa.png" width="400"> </div>

---

### 2️⃣ Init (watch this output carefully)

```bash
terraform init
```

You MUST see:

```
Initializing provider plugins...
- Installing kreuzwerker/docker ...
```

If you **don’t** see docker provider install → problem found.
<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task4-remote-state/Taskimg/initA.png" width="400">  </div>

---

### 3️⃣ Apply (NO auto-approve yet)

```bash
terraform apply
```

Say `yes`.

#### You MUST see:

```
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```
<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task4-remote-state/Taskimg/applyA.png" width="400">  </div>

---

### 4️⃣ IMMEDIATE verification (outside Terraform)

Now **prove** Terraform actually touched Docker.

```bash
docker network ls
```

#### You MUST see:

```
shared_app_network
```

<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task4-remote-state/Taskimg/networkA.png" width="400">  </div>

---

## 🧠 PHASE 2 — Project B (Consumer) — CLEAN BOOT

### 6️⃣ Go to Project B

```bash
cd ../project-b-app
```

Confirm:

```bash
ls
```

Must be:

```
main.tf
```

<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task4-remote-state/Taskimg/projB.png" width="400">  <img src="/IAC/Terraformtask/task4-remote-state/Taskimg/projBb.png" width="400"></div>

---

### 7️⃣ Init

```bash
terraform init
```

You MUST see docker provider install again.

<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task4-remote-state/Taskimg/initB.png" width="400">  </div>

---


### 8️⃣ Apply Project B

```bash
terraform apply
```

Say `yes`.

You MUST see:

```
Resources: 1 added
```

<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task4-remote-state/Taskimg/applyB.png" width="400">  </div>

---

### 9️⃣ Sanity-check remote state 

Run:

```bash
terraform console
```

Then:

```hcl
data.terraform_remote_state.network.outputs.network_name
```

Expected:

```
"shared_app_network"
```

If this fails → state path is wrong. No container should be created yet.

Exit console:

```bash
exit
```

<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task4-remote-state/Taskimg/CHECK.png" width="400">  </div>

---


## 🔎 PHASE 3 — Hard Docker verification

### 🔟 Is container running?

```bash
docker ps -a
```

You MUST see:

```
app_container
```

If container exists but stopped:

```bash
docker logs app_container
```

<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task4-remote-state/Taskimg/psB.png" width="400"> </div>

---

### 1️⃣1️⃣ Check port binding

```bash
docker inspect app_container | findstr 8085
```

You should see:

```
"HostPort": "8085"
```

<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task4-remote-state/Taskimg/port.png" width="400">  </div>

---

### 1️⃣2️⃣ Test nginx INSIDE container

```bash
docker exec -it app_container curl localhost
```

If this returns HTML → nginx is fine.

---

### 1️⃣3️⃣ Test from host

```bash
curl http://localhost:8085
```

Then browser:
👉 `http://localhost:8085`


<div style="display:flex; gap:10px;"> <img src="/IAC/Terraformtask/task4-remote-state/Taskimg/containerB.png" width="400">  <img src="/IAC/Terraformtask/task4-remote-state/Taskimg/localhostB.png" width="400"> </div>


---




## 🔍 What just happened ??

### `terraform_remote_state`

* Reads **outputs only**
* Cannot modify Project A
* Treats Project A like a black box

### Output consumption

```hcl
data.terraform_remote_state.network.outputs.network_name
```

This is how:

* VPCs feed apps
* Networks feed clusters
* Clusters feed services

---

## 🧱 State Isolation (why this saves your job)

If you run:

```bash
terraform destroy
```

inside **Project B**:

✅ Container dies
❌ Network stays alive

That isolation is **non-negotiable** in real infra.

---
---
<br><br>















# 🧩 TASK 4.1 — Dev / Prod Separation 

## Core rule 

> **Dev and Prod NEVER share state.
> They MAY share code.**

So:

* Same Terraform code
* Different folders
* Different state files
* Zero cross-contamination

---

## 📁 Final Folder Structure

```
terraform-remote-state/
├── project-a-network/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfstate
│   │
│   └── prod/
│       ├── main.tf
│       ├── outputs.tf
│       └── terraform.tfstate
│
└── project-b-app/
    ├── dev/
    │   └── main.tf
    │
    └── prod/
        └── main.tf
```

---

## 🅰️ Project A — Network (Dev & Prod)

### DEV app

#### `project-a-network/dev/main.tf`

```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "shared_net" {
  name = "dev_shared_network"
}
```

### `project-a-network/dev/outputs.tf`

```hcl
output "network_name" {
  value = docker_network.shared_net.name
}
```

---

### PROD app

#### `project-a-network/prod/main.tf`

```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "shared_net" {
  name = "prod_shared_network"
}
```

#### `project-a-network/prod/outputs.tf`

```hcl
output "network_name" {
  value = docker_network.shared_net.name
}
```

---

### Apply both (order doesn’t matter)

```bash
cd project-a-network/dev
terraform init
terraform apply

cd ../prod
terraform init
terraform apply
```

Now you have:

* `dev_shared_network`
* `prod_shared_network`
* Separate states
* Same code pattern

Perfect.

---

## 🅱️ Project B — App (Dev & Prod)

### DEV app

#### `project-b-app/dev/main.tf`

```hcl
provider "docker" {}

data "terraform_remote_state" "network" {
  backend = "local"
  config = {
    path = "../../project-a-network/dev/terraform.tfstate"
  }
}

resource "docker_container" "app" {
  name  = "dev_app_container"
  image = "nginx:latest"

  networks_advanced {
    name = data.terraform_remote_state.network.outputs.network_name
  }

  ports {
    internal = 80
    external = 8081
  }
}

resource "docker_container" "app_2" {
  name  = "dev_app_container_2"
  image = "nginx:latest"

  networks_advanced {
    name = data.terraform_remote_state.network.outputs.network_name
  }

  ports {
    internal = 80
    external = 8082
  }
}
```

---

### PROD app

#### `project-b-app/prod/main.tf`

```hcl
provider "docker" {}

data "terraform_remote_state" "network" {
  backend = "local"
  config = {
    path = "../../project-a-network/prod/terraform.tfstate"
  }
}

resource "docker_container" "app" {
  name  = "prod_app_container"
  image = "nginx:latest"

  networks_advanced {
    name = data.terraform_remote_state.network.outputs.network_name
  }

  ports {
    internal = 80
    external = 9091
  }
}
```

---


## 1️⃣ Destroy Project B → Network survives

```bash
cd project-b-app/dev
terraform destroy
```

Result:

* ❌ Containers gone
* ✅ `dev_shared_network` still exists

Same for prod if you do it there.

This proves **state isolation**.

---

## 2️⃣ Rename network in Project A

Edit **dev network**:

```hcl
name = "dev_shared_network_v2"
```

Then:

```bash
cd project-a-network/dev
terraform apply
```

Now re-apply dev app:

```bash
cd ../../project-b-app/dev
terraform apply
```

Terraform:

* Reads updated remote state
* Reattaches containers
* No manual changes

This is **cross-stack wiring done right**.

---

## 3️⃣ Second container using same remote state

You already did it:

```hcl
resource "docker_container" "app_2" {
  ...
}
```

Both containers:

* Same network
* No duplication
* No guessing

---
---