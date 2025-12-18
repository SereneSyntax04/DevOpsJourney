<h1 align='center'>Devops Foundation: <br> Infrastructure as Code</h1>

---
<br><br>



<h1 align="center">Chapter 1. Modern Infrastructure & Cloud Basics</h1>
<br>

## What is Cloud Computing?

Cloud computing is **on-demand access to compute, storage, and networking** over the internet, backed by real servers in global data centers.

### Core Characteristics (NIST)
- **On-demand self-service** – provision without human interaction  
- **Broad network access** – accessible from anywhere  
- **Resource pooling** – shared provider infrastructure  
- **Rapid elasticity** – scale up/down quickly  
- **Measured service** – pay only for what you use  

<br>

## Cloud Service Models


<p align="center">
  <img src="./assets/images/serviceModel.webp" alt="serviceModel" width="400"/>
</p>


### SaaS – Software as a Service
- Fully managed applications  
- No infrastructure or platform management  
- Examples: Salesforce, Office 365  

### PaaS – Platform as a Service
- Deploy code, provider manages OS/runtime  
- Examples: Azure App Service, Google App Engine  

### IaaS – Infrastructure as a Service
- VM-level access with OS control  
- Examples: AWS EC2, Azure VMs, GCP Compute Engine  
- **Primary layer for Infrastructure as Code**

<br>

## Why Cloud Enables Automation

Traditional on-prem infrastructure:
- Weeks to procure hardware  
- Fixed capacity  
- High upfront cost  

Cloud infrastructure:
- Servers in minutes  
- Dynamic scaling (1 → 100 instantly)  
- Pay-per-use  
- Fully API-driven → **automation friendly**  

---
<br>

<h1 align='center'>Bare Metal vs Cloud (Reality Check) </h1>

### Cloud Advantages
- Speed and agility  
- No hardware management  
- Easy scaling  
- Built-in APIs for automation  
- Access to GPUs, FPGAs, edge, and more  

### Cloud Challenges
- Can be expensive if poorly governed  
- Requires quotas, budgets, and policies  

### When Bare Metal Makes Sense
- Very stable, predictable workloads  
- Highly specialized custom hardware  

> In practice, **less than 10% of workloads require bare metal**.

---
<br>

<h1 align='center'> Modern Cloud Platforms and Managed Services </h1>

Modern cloud goes far beyond VMs and storage.
```
Modern cloud = managed services.
Instead of saying:
    “Give me a server and I’ll install a database”

You now say:
    “Give me a database service”

You work at a functional level, not infrastructure level.
```
### Managed Services
- Databases (SQL, NoSQL)
- Messaging and streaming
- DNS and CDN
- Observability and security
- Analytics and ML

Managed services let you work at a **functional level**:
- Store data
- Process events
- Translate text
- Visualize metrics

You don’t manage servers — **you consume capabilities**.

---
<br>


<h1 align='center'>Managed Services vs Bare Cloud (IaaS)</h1>

### Bare Cloud (Raw Infrastructure)
- You manage **VMs, OS, patches, scaling**
- Full control and customization
- More operational overhead
- Better for edge cases and extreme performance needs

Examples:
- Self-managed database on EC2
- Self-hosted Kubernetes cluster

```
Maximum control
Maximum effort
```
<br>

### Managed Services
- Cloud provider manages **servers, scaling, upgrades, availability**
- You focus on **configuration and usage**, not maintenance
- Faster time to value
- Reduced need for deep infra specialists

Examples:
- Managed DBs (RDS, Cloud SQL, MongoDB Atlas)
- Managed Kubernetes (EKS, AKS, GKE)

<br>

**Pros**
- Faster provisioning (minutes vs months)
- Less operational burden
- Easy scaling via APIs
- Ideal for startups and small teams

**Cons**
- Less low-level tuning
- Often behind bleeding-edge versions
- Higher cost for convenience
- Vendor lock-in (not portable across clouds)

> Reality: **~90% of companies don’t need extreme customization**  
> Speed to market usually beats perfect control.

---
<br>

<h1 align='center'>Containers: The Backbone of Modern IaC</h1>

### What is a Container?
A container is a **lightweight, executable package** that includes:
- Application code
- Runtime
- Libraries & dependencies
- Configuration

Runs consistently across environments.

---

### Containers vs Virtual Machines

| Virtual Machines | Containers |
|------------------|------------|
| Full OS per VM   | Share host OS kernel |
| Heavy, slow boot | Lightweight, fast |
| More isolation   | Enough isolation for apps |

Containers virtualize **above the OS**, not the hardware.


<p align="center">
  <img src="./assets/images/compare.png" alt="compare" width="400"/>
</p>

---

### Why Containers Matter
- Fast startup
- Small size
- Environment consistency (dev = prod)
- Perfect fit for automation and IaC

You don’t even need a full OS inside a container — just the runtime (e.g., Python, Go).

---

## Container Ecosystem

### Container Runtimes
- Docker (most popular)
- containerd
- CRI-O
- rkt (legacy)

### Docker Images
- Built using a **Dockerfile**
- Declarative, repeatable, versioned
- Stored in image registries (Docker Hub, ECR, GCR)

Basic idea:
- Define environment in code
- Build once
- Run anywhere

---
<br>

<h1 align='center'> Kubernetes: Containers at Scale</h1>

## Kubernetes:
- **Orchestrates** containers across many servers
- Handles:
  - Scheduling
  - Scaling
  - Self-healing
  - Networking
- Enables **microservices architectures**

Containers run in **pods**, spread across **nodes**, managed automatically.

---

## Containers + IaC = Perfect Match

- Containers are built from code
- Infrastructure is provisioned from code
- Deployments become:
  - Reproducible
  - Predictable
  - Automatable

> Containers make applications portable.  
> IaC makes infrastructure repeatable.

---
<br>