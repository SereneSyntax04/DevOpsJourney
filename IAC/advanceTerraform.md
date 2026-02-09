# Detailed explanation of Advanced concept used in Terraform 

---

# Terraform Functions

Terraform includes built-in functions that can be used to transform and combine values.

- ⚠️ Terraform **does NOT support user-defined functions** — only built-in ones.

The general syntax for functions is a function name followed by comma separated arguments in parentheses: <br>
```
function_name(argument1, argument2, ...)
```

A specific example of this:
> max(5, 12, 9)
> Output: 12
The max function outputs the largest argument.


## Test Functions Using Terraform Console

Terraform provides a console to test functions before using them in code.

### Run:

```bash
terraform console
```

Then test:

<div style="display:flex; gap:10px;"> <img src="/IAC/img/3.png" width="500">  </div>

---

A complete list of supported functions can be found here: [Terraform Registry - Functions](https://developer.hashicorp.com/terraform/language/functions)


---
<br>


# Terraform Data Sources

## 🔍 What is a Data Source?

A **Data Source** lets Terraform:

* Fetch existing resource data
* Get dynamic values from cloud providers
* Avoid hardcoding values
* Make code reusable across regions


## ❌ Problem Without Data Source

Example — Hardcoded AMI:

```hcl
resource "aws_instance" "web" {
  ami = "ami-0abcdef12345"
}
```

🚫 Problem:

* AMI IDs change by region
* If region changes → AMI must be changed manually
* Code becomes hard to maintain

## ✅ Solution — Use Data Source

Terraform can automatically find the correct AMI.

### Data Source Syntax

```hcl
data "provider_resource" "name" {
  config
}
```

---

## 🧱 Example — Get Latest Amazon Linux AMI

```hcl
data "aws_ami" "app_ami" {

  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

}
```

## Explanation 

`data "aws_ami" "app_ami"`, the data source is "aws_ami" and we have named the data source "app_ami".

`most_recent = true`, Always fetch latest version of the AMI

`owners = ["amazon"]`, Only select AMIs created by Amazon

**Imagine AWS AMIs stored like a table:**
| ami-id  | name               | owner  | architecture | virtualization-type |
| ------- | ------------------ | ------ | ------------ | ------------------- |
| ami-123 | amzn2-ami-hvm-2024 | amazon | x86_64       | hvm                 |


### `filter block` (the exact instance type we want (Amazon Ubuntu).)

```hcl
filter {
  name   = "name"  
  values = ["amzn2-ami-hvm*"]
}

filter {
  name = "owner"
  value = "amazon"  
}
```

- Filters AMI by name pattern
- Wildcard `*` means match any version

We have then called this data source within the aws_instance resource block to get the correct AMI for whatever region we have specified in the provider block.

Now no matter what region we select Terraform will always pull the correct AMI for that region from the "aws_ami" data source.

### Using Data Source in Resource

Now reference it inside your EC2 resource:

```hcl
resource "aws_instance" "web" {

  ami           = data.aws_ami.app_ami.id
  instance_type = "t2.micro"

}
```

---

### 🧠 How This Helps

If you change region:

```hcl
provider "aws" {
  region = "us-east-1"
}
```

Terraform will automatically:

✅ Find correct AMI for that region
✅ No need to change AMI manually
✅ More reusable code
✅ Fewer errors


---
<br>


# Terraform Debugging 

## What is Terraform Debugging?

Terraform provides built-in debug logging to help you:

- Understand what Terraform is doing internally
- Troubleshoot errors
- Trace provider/API calls
- Diagnose plan/apply failures

Debug logs are controlled using an **environment variable** called: **TF_LOG**


## Enable Terraform Debug Logs

You enable logging by setting the `TF_LOG` environment variable.

Terraform supports multiple log levels.

### Log Levels (Low → High Detail)

| Level | Description |
|--------|-------------|
ERROR | Only errors |
WARN | Warnings + errors |
INFO | General operational info |
DEBUG | Detailed debugging info |
TRACE | 🔥 Most detailed (full internal trace) |

👉 **TRACE = most verbose**

---

## Enable Debug Logs — Linux / macOS

## Enable TRACE logging

```bash
export TF_LOG=TRACE
````

Run Terraform command:

```bash
terraform apply
```

Logs will print directly in terminal.


## Enable Debug Logs — Windows (PowerShell)

```powershell
$env:TF_LOG="TRACE"
```

---

## Save Logs to a File (Recommended)

Instead of printing logs in terminal, save them to a file.

### Linux / macOS

```bash
export TF_LOG_PATH=/path/to/terraform.log
```

Example:

```bash
export TF_LOG_PATH=./terraform-debug.log
```

Now logs go into that file when you run Terraform.


### Windows (PowerShell)

```powershell
$env:TF_LOG_PATH="terraform-debug.log"
```

---

## Example Debug Session

### Step 1 — Enable logs

```bash
export TF_LOG=DEBUG
export TF_LOG_PATH=debug.log
```

### Step 2 — Run Terraform

```bash
terraform plan
```

### Step 3 — Open log file

```
debug.log
```

You will see:

* Provider calls
* Resource evaluation
* API responses
* Dependency graph steps

---

## 🔥 When to Use TRACE Level

Use `TRACE` when:

* Provider is failing
* API calls are unclear
* Resource creation behaves unexpectedly
* Terraform crashes
* Deep troubleshooting needed

⚠️ TRACE logs are very large.

---

## 🧹 Disable Terraform Debug Logs

To disable logging set the TF_LOG variable to **empty**:

### Linux / macOS

```bash
export TF_LOG=
```

### Windows (PowerShell)

```powershell
Remove-Item Env:TF_LOG
```

---
<br>



# Terraform Dynamic Blocks

Dynamic blocks in Terraform let you **generate repeatable nested blocks automatically** instead of writing them again and again.

They are useful when:
- A resource needs many similar nested blocks
- Values change but structure stays same
- You want cleaner, shorter code

Supported inside:
- resource
- data
- provider
- provisioner blocks

---

A **nested block** is a block inside another block.

Example: `ingress` inside `aws_security_group`

```hcl
resource "aws_security_group" "example" {
  ingress {
    from_port = 80
    to_port   = 80
  }
}
```

If you need 40 ingress rules → you would normally write 40 ingress blocks ❌ <br>
Dynamic block solves this ✅

---

## Basic Dynamic Block Example (Using List)

### Step 1 — Define list variable

```hcl
variable "ingress_ports" {
  default = [8200, 8201, 8300, 9000]
}
```

### Step 2 — Use Dynamic Block

```hcl
resource "aws_security_group" "example" {

  dynamic "ingress" {
    for_each = var.ingress_ports

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

}
```

<div style="display:flex; gap:10px;"> <img src="/IAC/img/dynamic.png" width="500">  </div>


---

## How This Works ?

`for_each = var.ingress_ports`

Terraform loops through each port in the list.

For each item → creates one ingress rule.

Iteration values:

```
ingress.value → 8200
ingress.value → 8201
ingress.value → 8300
ingress.value → 9000
```

Result → 4 ingress rules created automatically.

---

## Why `ingress.value` and NOT `ingress_ports.value`?

Because:

* `ingress` = name of dynamic block
* Terraform assigns each loop value to the block iterator
* So we access it using → `ingress.value`

It refers to the **current loop item**, not the variable name.

---

## Using Iterator

You can rename the iterator for readability.
That is:

previously terraform's internal behaviour was:
```bash
for ingress in ingress_ports:
```


Using Iterator:

```hcl
dynamic "ingress" {
  for_each = var.ingress_ports
  iterator = port

  content {
    from_port = port.value
    to_port   = port.value
  }
}
```
Now terraform's internal behaviour will be:
```bash
for port in ingress_ports:
```
now instead of being ingress.value it is port.value. This can make dynamic blocks easier to read and understand. 

**It renames the loop variable for readability.**

---

## 🔹 Multiple Dynamic Values (Use List of Maps)

If you need more than one changing value (like port + CIDR), use list of maps.

### Variable

```hcl
variable "rules" {
  default = [
    { port = 80,  cidr = ["0.0.0.0/0"] },
    { port = 22,  cidr = ["10.0.0.0/8"] }
  ]
}
```

This way we can define the values like: 
```
from_port = ingress.value["port"]
to_port = ingress.value["port"]
protocol = "tcp"
cidr_blocks = ingress.value["cidr"]
```

---

### Dynamic Block

```hcl
dynamic "ingress" {
  for_each = var.rules

  content {
    from_port   = ingress.value["port"]
    to_port     = ingress.value["port"]
    protocol    = "tcp"
    cidr_blocks = ingress.value["cidr"]
  }
}
```

---
<br>

# Terraform Taint

You create an EC2 instance using Terraform.

Later:
- Someone makes manual changes in AWS console
- Or changes software/config inside the server

Now:
❌ Real infrastructure ≠ Terraform code  
This is called **drift**

You may decide:
- Import changes → update Terraform
OR
- Destroy & recreate → clean rebuild ✅

## What is Terraform Taint?

Terraform taint marks a specific resource as:

> ⚠️ “Bad / needs replacement”

On next `terraform apply`:
- Terraform will **destroy**
- Then **recreate**
- Only that resource (not everything)

## IMPORTANT: Terraform deprecated taint after v0.15.2
**Use "-replace" flag instead**

```bash
terraform apply -replace=aws_instance.my_ec2
```

Safer way: PLAN FIRST
```bash
terraform plan -replace=aws_instance.my_ec2
```
Then apply if correct.


---
<br>


# Terraform Splat Expressions (*)

A **splat expression (`*`)** lets you get the **same attribute from many resources at once**.

Think of it like:

> “Give me this field from ALL items in the list.”

It avoids writing repeated lines of code.

## Example:
Create Multiple Resources
```bash
resource "aws_iam_user" "lb" {
  count = 3
  name  = "user-${count.index}"
}
```

Terraform creates: aws_iam_user.lb[0], aws_iam_user.lb[1], aws_iam_user.lb[2]

So internally it’s like a list of 3 users.

**Now, You Want Their ARNs:**

- Without splat, you must ask one by one:
```
aws_iam_user.lb[0].arn
aws_iam_user.lb[1].arn
aws_iam_user.lb[2].arn
```

- Terraform gives a shortcut: **splat expression (`*`)**
```
aws_iam_user.lb[*].arn
```
aws_iam_user.lb   → all users created by this block <br>
[*]               → every index <br>
.arn              → get arn field


---
---
<br><br>


[Return to course](/IAC/DetailedTheoryTerraform.md) | [Basic Concepts of Terraform](/IAC/basicTerraform.md)