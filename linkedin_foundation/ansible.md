<br>

[⚡ Quick Reminder: Two Layers of Automation](devops_foundation_IAC.md)

```
Provisioning (Terraform) → Creates servers, networks, and cloud resources

Configuration (Ansible) → Sets up software and applications on those servers

Don’t mix the two—each solves a different problem.
```
<br>

---

# Ansible
**Detailed Beginner-Friendly Explanation:**

## Big Picture

After provisioning servers with Terraform, you still need to install **software** like Kubernetes. Terraform creates servers; Ansible **configures them**.

Think of it like:

* Terraform → Build the house
* Ansible → Furnish it, connect utilities, decorate

---

## 1. Playbooks – Your Instructions

A **playbook** is a YAML file with tasks that Ansible runs.

* **Simple example:** Check Ansible version
* **Real example:** `cluster.yml` sets up all Kubernetes nodes
* Playbooks can include other playbooks (nested) for modularity

---

## 2. Roles – Organizing Work

Roles are **collections of tasks** grouped by function:

* Example: `Bootstrap OS` role → updates server, installs Python, sets up packages
* Inside roles:

  * `package:` → Ansible installs a software package
  * `raw:` → Executes raw commands not supported by built-in modules

Roles make playbooks **clean, reusable, and readable**.

---

## 3. Inventory File – Know Your Servers

Terraform produces an **inventory file** listing all hosts:

* Divided by roles (control plane vs worker)
* Ansible uses it to know **where to run tasks**

> Without this file, Ansible wouldn’t know which server to configure.

---

## 4. Running Ansible

Basic command structure:

```bash
ansible-playbook -i inventory scale.yml
```

* `-i inventory` → tells Ansible which hosts to manage
* `scale.yml` → playbook for scaling or updating nodes

**Process:**

1. Reads inventory → knows which servers are missing software
2. Runs tasks in order → installs prerequisites, software, configurations
3. Applies changes safely → can run multiple iterations to ensure everything works

---

## 5. Real-Life Example: Scaling a Kubernetes Cluster

* Terraform adds a 4th worker node
* Inventory updates automatically
* Ansible `scale.yml` installs Kubernetes on the new node
* Result: Cluster grows **without manual installation**, fully ready to use

---

## 6. Why Ansible is Powerful

* **Repeatable:** Same tasks on multiple servers reliably
* **Safe:** Can test and review playbooks before running
* **Flexible:** Runs locally or remotely
* **Orchestrates workflows:** Upgrade clusters, roll out changes, apply configurations without downtime

---

## 7. One-liner Takeaway

> Ansible automates configuration management, orchestrating tasks across servers, so you never have to manually install, configure, or update software again.

---