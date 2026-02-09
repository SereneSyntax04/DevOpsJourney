# Detailed explanation of Basic concept used in Terraform 

---

# Providers

* A **provider** is a **plugin** that lets Terraform talk to a specific platform API (AWS, Azure, GCP, Kubernetes, etc.).
* You must choose a provider based on the infrastructure you want to create.
* Terraform cannot create resources without a provider.


## Initialization Rule

* Whenever you **add or change a provider**, run:

```bash
terraform init
```

* This downloads the required **provider plugins**.
* Terraform detects the provider from your code and installs it automatically.


## Provider Types

* **HashiCorp maintained** → aws, azurerm, google, kubernetes, etc.
* **Community / non-HashiCorp maintained** → third-party providers.


## Best Practice Provider Syntax (Terraform v0.13+)

Use two blocks:

### 1️⃣ Required Providers (source + version)

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.33.0"
    }
  }
}
```

### 2️⃣ Provider Configuration

```hcl
provider "aws" {
  region = "us-east-1"
}
```

* Ensures correct provider source and version.
* Recommended for all providers.
* Ready-made blocks are available on the **Terraform Registry**.

[example of Provider Syntax](/IAC/Terraformtask/task1-workspaces-nginx/main.tf)


---
<br>


# Resources

* A **resource** represents a specific infrastructure service created by a provider.
* Format:

  ```
  resource "<provider>_<service>" "<name>"
  ```
* Example: AWS EC2 resource → `aws_instance`

```hcl
resource "aws_instance" "web" {
  ami           = "ami-xxx"
  instance_type = "t2.micro"
}
```

* Providers offer **many resource types** [check Terraform Registry for full list](https://registry.terraform.io/providers/hashicorp/aws/latest)
* Resources can be very detailed with many configuration options.

<div style="display:flex; gap:10px;"> <img src="/IAC/img/1.png" width="500">  </div>

* Resource Type - An unchangeable resource type used by Terraform that refers to a specific resource type for a provider
* Local Resource Name - The name you give to the resource you create, it is a custom value and can be anything you want. Do note this name only applies locally with


##  Using a Non-AWS Provider — Example (GitHub)

* Terraform supports non-cloud providers like **GitHub**.
* Each provider has its own resource types and authentication method.

### Best Practice Provider Setup

```hcl
terraform {
  required_providers {
    github = {
      source = "integrations/github"
    }
  }
}

provider "github" {
  token = var.github_token
}
```

* Provider block syntax is available via **Terraform Registry → “Use Provider”** button.
* Authentication differs by provider:

  * AWS → access keys / roles
  * GitHub → personal access token

## ▶️ Run Terraform

```bash
terraform init   # download provider plugins
terraform plan   # preview changes
terraform apply  # create resources
```

* Same workflow for all providers.
* Only resource types and auth method change.


---
<br>


# Terraform State File

## What is Terraform State?

* Terraform stores details of created infrastructure in a **state file** (`terraform.tfstate`).
* This state file allows Terraform to map real world resources to your configuration files.
* Automatically created after `terraform init` and updated after `terraform apply`.

> Terraform uses state to know what already exists.


## Why State File is Important

State helps Terraform decide:
What to create, update, delete and ignore

Example:

* EC2 already in state → not recreated
* GitHub repo not in state → will be created


## State Updates

* `terraform apply` → adds resources to state
* `terraform destroy` → removes resources from state
* Resource removed from state but still in code → Terraform plans to recreate it


## Desired vs Current State

**Desired State** = What is defined in `.tf` files
**Current State** = What actually exists in the cloud

Terraform always tries to make:

> Current State = Desired State


## ⚠️ Important Rules

* State file is **managed by Terraform**
* ❌ The state file is maintained by Terraform itself, is not something you should ever really be directly editing. 
* Contains sensitive data → store securely (remote backend in real projects)
* An important thing to note is that if something is not specified in the .tf config file then it is not part of the desired state. (manual additon of certain resources.)



---
<br>


# Terraform Attributes & Output Values 

## Attributes

* **Attributes** are properties of a created resource.
* Example attributes:

  * EC2 → `public_ip`, `id`, `arn`
  * S3 → `bucket_domain_name`
  * EIP → `public_ip`
* Available attributes are listed in the **Terraform Registry** for each resource.

Reference format:

```hcl
resource_type.resource_name.attribute
```

Example:

```hcl
aws_eip.lb.public_ip
```


## Output Values

* `output` blocks display selected resource attributes after `terraform apply`.
* Outputs can also be **used as inputs for other resources/modules**.


## 🧱 Example

```hcl
resource "aws_eip" "lb" {
  domain = "vpc"
}

resource "aws_s3_bucket" "mys3" {
  bucket = "unique-bucket-name-123"
}
```

### Outputs

```hcl
output "eip_ip" {
  value = aws_eip.lb.public_ip
}

output "s3_domain" {
  value = aws_s3_bucket.mys3.bucket_domain_name
}
```

Result after apply → Terraform prints these values.

<div style="display:flex; gap:10px;"> <img src="/IAC/img/2.png" width="500">  </div>


---
<br>


# Terraform Variables 

##  Why Use Variables?

* Avoid repeating static values (IP, region, instance size, etc.)
* Makes code easier to update and reuse
* Change value once → updates everywhere
* Reduces human error


##  Define a Variable (variables.tf)

Create a central variable file:

```hcl
variable "vpn_ip" {
  type    = string
  default = "116.30.45.50/32"
}
```


##  Use Variable in Resources

Reference variables with:

```
var.variable_name
```

Example — Security Group:

```hcl
resource "aws_security_group" "sg" {
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }
}
```

Terraform replaces `var.vpn_ip` with the actual value during plan/apply.

---
<br>

# Terraform Variable Assignment

Variables can get values from:

### 1️⃣ Variable Default (variables.tf)

```hcl
variable "instancetype" {
  default = "t2.micro"
}
```

Used if nothing overrides it.

---

### 2️⃣ terraform.tfvars (Best Practice Override)

You override the default value here.

```hcl
instancetype = "t2.small"
```

---

### 3️⃣ Custom tfvars File

```bash
terraform apply -var-file="prod.tfvars"
```

Used for dev/stage/prod configs.

---

### 4️⃣ Command Line Flag (Quick Override)

```bash
terraform plan -var="instancetype=t2.small"
```

Not best practice for production.

---

### 5️⃣ Environment Variable (Highest Priority)

```bash
export TF_VAR_instancetype="t2.nano"
```

Terraform checks this first.

---
<br>


# Terraform Variable Data Types 

Always set a **type** in variables → prevents wrong values and errors. 

## Common Variable Types

### 🔤 string — text value

```hcl
variable "region" {
  type = string
}
```

Example: `"us-east-1"`


### 🔢 number — integer or decimal

```hcl
type = number
```

Examples: `10`, `3.14`


### ✅ bool — true/false

```hcl
type = bool
```

Examples: `true`, `false`


### 📚 list (tuple) — ordered values

```hcl
type = list(string)
```

Example:

```hcl
["us-west-1a", "us-west-1c"]
```

Access with index → `var.zones[0]`


### 🗂 map (object) — key/value pairs

```hcl
type = map(string)
```

Example:

```hcl
{ env = "dev", owner = "team1" }
```

Access → `var.tags["env"]`

---

## 📚 Using Lists & Maps with Terraform Variables 

## 🗂 Map Variable — Use Key

Map = key → value pairs.

### Example Map

```hcl
variable "types_of_ami" {
  type = map(string)
  default = {
    us-east-1 = "t2.micro"
    us-west-2 = "t2.small"
  }
}
```

### Access Specific Value

```hcl
instance_type = var.types_of_am["us-east-1"]
```

👉 Uses the value for that key → `t2.micro`


## 📋 List Variable — Use Index

List = ordered values (index starts at **0**).

### Example List

```hcl
variable "list_of_ami_for_apSouth1" {
  type = list(string)
  default = ["m5.large", "t2.micro", "t3.small"]
}
```

### Access Specific Value

```hcl
instance_type = var.list_of_ami_for_apSouth1[0]
```

👉 Index 0 = first value → `m5.large`


---
<br>


# Terraform Count

The count parameter on resources can simplify configurations and let you **scale resources by simply incrementing a number**. 

Creating many identical resources by copying blocks = messy ❌


## ✅ Solution — `count`

Use `count` to create multiple resources from **one block**.

```hcl
resource "aws_instance" "web" {
  count = 5

  ami           = "ami-xxx"
  instance_type = "t2.micro"
}
```

👉 Creates 5 EC2 instances.

Terraform references:

```
web[0], web[1], web[2], web[3], web[4]
```

(Only Terraform names — not AWS console names.)

---

## 🆔 Make Names Unique — `count.index`

If a resource requires a unique value / identifier and you want to use the count parameter to build multiple of them, then you can use count index to make them unique.

Use index number inside values:

```hcl
resource "aws_iam_user" "user" {
  count = 3
  name  = "user-${count.index}"
}
```

Result:

```
user-0, user-1, user-2
```

---

## 📚 Better Naming with List + count

```hcl
variable "iam_users" {
  default = ["dev-user", "stage-user", "prod-user"]
}

resource "aws_iam_user" "user" {
  count = 3
  name  = var.iam_users[count.index]
}
```

👉 Each resource gets name from list.

---
<br>

# Conditional Expressions 
Conditional expressions select one of two Boolean values (true or false).

Structure of a conditional expression:
**condition ? value_if_true : value_if_false**

## Condition:
Create **Dev OR Prod resource** depending on environment — not both.

### Boolean Variable

```hcl
variable "istest" {
  type = bool
}
```

Value set in `terraform.tfvars`:

```hcl
istest = true
```

### Conditional Count Syntax

```hcl
count = var.istest == true ? 1 : 0
```

Meaning:

👉 if true → create 1
👉 if false → create 0 (don’t create)


## 🧱 Example — Dev vs Prod

### Dev Resource

```hcl
resource "aws_instance" "dev" {
  count = var.istest ? 1 : 0
}
```

### Prod Resource

```hcl
resource "aws_instance" "prod" {
  count = var.istest ? 0 : 1
}
```

Result:

* `istest = true` → Dev created only
* `istest = false` → Prod created only


## 🔢 You Can Scale Too

```hcl
count = var.istest ? 4 : 0
```

👉 Create 4 resources only if test = true.

---
<br>


# Local Values

## 📌 What Are Locals?

* **Locals = named expressions used multiple times**
* Reduce repetition inside a module
* Defined once → reused many times

## 🧱 Define Locals

```hcl
locals {
  common_tags = {
    env = "dev"
    team = "cloud"
  }
}
```

Use in resources:

```hcl
tags = local.common_tags
```

⚠️ Define with `locals {}`
⚠️ Use with `local.` (no **s**)

---

## 🔍 Locals vs Variables

* **Variables** → static input values
* **Locals** → can use **expressions & logic**

## ⚙️ Locals with Expressions

```hcl
locals {
  name_prefix = var.name != "" ? var.name : var.default
}
```

Meaning:

* If `var.name` exists → use it
* Else → use default value

---
<br>


# Terraform Formatting

Terraform provides a built-in command to automatically format your `.tf` files using standard best-practice style.


## Command

Format all Terraform files in current directory:

```bash
terraform fmt
```

- Format Specific File

```bash
terraform fmt my_ec2.tf
```

---
<br>

# Terraform Validate

`terraform validate` checks whether your Terraform configuration is **syntactically correct and internally valid**.

It helps detect errors before running plan/apply.

## command
```bash
terraform validate
```

## Best Praactice:
Run validate after writing or editing Terraform code: <br>
terraform validate → terraform plan → terraform apply

---
<br>


# Terraform Workspaces

## What Problem They Solve

Terraform Workspaces let you reuse the same Terraform code for multiple environments by keeping a separate state file per workspace.

* By default → **1 Terraform project = 1 state file**
* Risk: dev/stage/prod can overwrite each other

> Workspaces give **separate state files** for each environment.


## State Separation

Instead of one state file:

```
terraform.tfstate
```

You get:

```
terraform.tfstate.d/dev
terraform.tfstate.d/stage
terraform.tfstate.d/prod
```


##  Basic Commands 

```bash
terraform workspace list
terraform workspace show
terraform workspace new dev
terraform workspace select dev
terraform workspace delete dev
```


## Basic Usage Flow

```bash
terraform workspace new dev
terraform workspace select dev
terraform apply
```


## ⚠️ Warning

`terraform destroy` affects the **current workspace only**

Always check:

```bash
terraform workspace show
```


---
---
<br><br>


[Return to course](/IAC/DetailedTheoryTerraform.md) | [Advance Concept of Terraform](/IAC/advanceTerraform.md)