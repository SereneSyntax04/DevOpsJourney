
# Terraform Core Concepts — Resource, Data, Provider (Simple & Clear)

## 1. Resource — *The Creator*

A **resource** tells Terraform to **create, update, or delete** something.

> If Terraform is *doing* something → it’s a **resource**.

### Syntax
```hcl
resource "<provider>_<type>" "<name>" {
  # configuration
}
```

### Example (Docker container)

```hcl
resource "docker_container" "nginx" {
  name  = "nginx-dev"
  image = "nginx:latest"

  ports {
    internal = 80
    external = 8081
  }
}
```

### Key Points

* Resources **change infrastructure**
* Terraform tracks them in **state**
* Destroying a resource = real deletion

📌 
Resource = *ordering food*
“You want Terraform to make something real.”

---

## 2. Data Source — *The Reader*

A **data source** is used to **read existing information**.
Terraform does **NOT** create anything here.

> If Terraform is *looking up* something → it’s **data**.

### Syntax

```hcl
data "<provider>_<type>" "<name>" {
  # lookup configuration
}
```

### Example (Docker image)

```hcl
data "docker_image" "nginx" {
  name = "nginx:latest"
}
```

### Key Points

* Read-only
* No lifecycle (no create/update/destroy)
* Used to fetch IDs, names, metadata

📌 
Data = *checking the menu*
“You’re asking what already exists.”

---

## 3. Resource vs Data (MOST IMPORTANT DIFFERENCE)

| Resource             | Data Source                |
| -------------------- | -------------------------- |
| Creates infra        | Reads infra                |
| Changes real systems | No changes                 |
| Stored in state      | Also stored, but read-only |

### Correct usage together

```hcl
data "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx" {
  name  = "nginx-dev"
  image = data.docker_image.nginx.image_id
}
```

✅ Data finds the image
✅ Resource creates the container

---

## 4. Provider — *The Translator*

Terraform itself does nothing.
A **provider** talks to the real platform (AWS, Docker, Azure, etc).

### Example

```hcl
provider "docker" {}
```

### Key Points

* One provider = one platform
* Providers expose **resources** and **data sources**

📌 
Provider = *language translator*
Terraform speaks → platform understands

---

## 5. State — *Terraform’s Memory*

Terraform stores infrastructure info in:

```
terraform.tfstate
```

State contains:

* What resources exist
* Their real IDs
* Current configuration

Without state:
❌ Terraform is blind
❌ Unsafe changes

### Workspaces

Workspaces = **multiple state files**

```
dev  → dev state
prod → prod state
```

Same code. Different environments.

---

## 6. Variables — *Input Values*

Variables avoid hardcoding.

```hcl
variable "port" {
  type    = number
  default = 8081
}
```

Use it:

```hcl
external = var.port
```

📌 
Variables = knobs you turn

---

## 7. Outputs — *Results*

Outputs show useful info after `terraform apply`.

```hcl
output "nginx_url" {
  value = "http://localhost:${var.port}"
}
```

Used for:

* Debugging
* Passing values to other modules
* Visibility

---

## 8. Modules — *Folders with Purpose*

A **module** is just a folder containing Terraform files.

Used to:

* Reuse code
* Keep infra clean
* Avoid copy-paste

```hcl
module "nginx" {
  source = "./modules/nginx"
}
```

📌 Modules don’t make you advanced
📌 Understanding **resource + data + state** does

---
