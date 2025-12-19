
[click here to refer Terraform Project]()
<br>

## Big picture first

You already know AWS lets you create servers by clicking buttons.

Terraform answers this question:

👉 **What if we create ALL of that using code instead of clicking?**

That’s exactly what’s happening in this video.

---

## Step 1: Servers already exist… but nobody clicked anything

When the instructor opens AWS EC2, they see:

* Multiple servers running
* Bastion host
* Kubernetes master nodes
* Kubernetes worker nodes
* Networking + security

Your first thought might be:

> “Okay, someone manually created these.”

❌ Wrong.

✅ **Terraform created ALL of this from code.**

That’s the magic.

---

## Step 2: Where does this code live?

They used an **open-source project** called **Kubespray**.

Inside that project:

* There’s a folder with **Terraform code**
* That code describes:

  * Networks (VPC)
  * Load balancers
  * Servers
  * Security rules
  * How many Kubernetes nodes to run

So instead of clicking:

> “Create VPC → Create server → Configure security…”

They wrote:

> “This is what I want. Terraform, go build it.”

---

## Step 3: The `terraform.tfvars` file (the control panel)

This file is **very important**.

Think of it like:

> ⚙️ “Settings file for your infrastructure”

In this file, they define things like:

* Number of worker nodes (e.g., 3)
* Instance size
* Region

So when it says:

> workers = 3

Terraform understands:

> “Okay, create 3 worker servers.”

No loops. No scripts. Just a number.

---

## Step 4: Main Terraform files (the blueprint)

The main `.tf` files describe:

* What resources to create
* How they connect
* What depends on what

Example in simple terms:

* Create a network
* Inside that network, create servers
* Attach security rules
* Attach load balancers

Terraform also uses **modules**:

* Small reusable blocks of Terraform code
* Example:

  * One module only creates VPC
  * Another module creates EC2 servers

This keeps things clean and manageable.

---

## Step 5: Terraform State (`tfstate`) – Terraform’s memory

This is CRITICAL.

After Terraform runs, it creates a **state file**.

This file answers:

* What did Terraform create?
* What is currently running?
* IDs, IPs, metadata, everything

Think of it as:

> 🧠 Terraform’s brain

Without state:

* Terraform wouldn’t know what exists
* It could accidentally recreate or destroy things

In real projects:

* State is stored remotely (S3, database)
* Not on someone’s laptop

---

## Step 6: Making a change (this is the key lesson)

They want **more power**, so they decide:

> “Let’s add one more Kubernetes worker.”

Old way (manual):

* Click EC2
* Launch instance
* Configure networking
* Pray you didn’t forget anything

Terraform way:

* Open `terraform.tfvars`
* Change:

  ```
  workers = 3 → workers = 4
  ```

That’s it.

---

## Step 7: Terraform commands (what each one really does)

### `terraform validate`

👉 “Is my code written correctly?”

* Checks syntax
* Doesn’t touch AWS

---

### `terraform plan`

👉 “What will change if I apply this?”

Terraform compares:

* **Desired state** (code)
* **Current state** (tfstate + AWS)

Then says:

* I will create 1 new server
* I will NOT touch existing ones

This is your **safety net**.

---

### `terraform apply`

👉 “Okay, do it for real.”

* Terraform shows plan again
* You say “yes”
* AWS starts creating the new server

Within minutes:

* New worker node appears in EC2
* Cluster grows from 3 → 4 nodes

---

## Step 8: Why this is powerful (the real lesson)

Terraform gives you:

✅ Repeatability
Same setup every time, zero guesswork

✅ Reviewability
Others can review your infra like code

✅ Safety
You see changes *before* they happen

✅ Scalability
Change numbers, not servers manually

✅ No click mistakes
Humans are bad at clicking consistently

---

## The one-line takeaway (burn this into memory)

> **Terraform lets you describe infrastructure once, and then safely create and change it forever using code.**

That’s why it’s everywhere in DevOps jobs.

---
---






