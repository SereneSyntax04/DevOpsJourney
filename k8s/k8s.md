# What is Kubernetes (K8s)?

## Definition
**Kubernetes** is an **open-source container orchestrator** that automates:
- Deploying containerized applications
- Scaling them up/down
- Managing failures and restarts

Think of it as the **captain of a ship** deciding *where containers run, how many run, and what happens when things break*.


<div style="display:flex; justify-content:center; align-items:center; gap:10px;">
  <img src="/k8s/img/k8s.png" width="400">
</div>

---

## Quick History
- Announced by **Google (2014)**
- Open-sourced in **2015**
- Inspired by Google’s internal system **Borg**
- Donated to the **Cloud Native Computing Foundation (CNCF)**

---

## Why Kubernetes Exists
Running containers manually doesn’t scale.

Kubernetes solves:
- **Auto-scaling** (traffic ↑ → pods ↑)
- **Self-healing** (crash → restart automatically)
- **Load balancing**
- **High availability**
- **Efficient resource usage**

---

## Key Facts
- Written in **Go**
- Runs **anywhere**: on-prem, cloud, hybrid
- Nicknames: **K8s**, **Kates**
- Name meaning: *Helmsman / Pilot*

---

## Real-World Usage
- **96% of organizations** use or evaluate Kubernetes (CNCF survey)
- Used by companies like **Spotify**
- Handles **millions of requests per second**
- Deployments go from **hours → minutes**

---

## Kubernetes in the Cloud
You can:
- Install it yourself, or
- Use **Managed Kubernetes**:
  - GKE (Google)
  - EKS (AWS)
  - AKS (Azure)
  - Others: IBM, Red Hat, DigitalOcean

---

## Why It Matters
Kubernetes enables **planet-scale applications**:
- Start small
- Grow to massive scale
- Pay only for what you use

That’s why Kubernetes is *everywhere*.


---
<br>


# What are Containers?

## Definition
A **container** is a lightweight unit that bundles:
- Application code
- Configuration
- Dependencies

All packed together so the app runs **the same everywhere**.

Containers were pioneered and popularized by **Docker**.

<div style="display:flex; justify-content:center; align-items:center; gap:10px;">
  <img src="/k8s/img/docker-container.png" width="400">
</div>

---

## Why Containers Exist
Before containers:
- Apps needed separate servers or VMs
- Setup was slow and inconsistent
- Scaling was expensive

Containers solved this.

---

## Key Advantages
- **Portable**: Run on Linux, Windows, macOS (with a container engine)
- **Lightweight**: Use less CPU & memory than virtual machines
- **Fast**: Start and stop in seconds
- **Scalable**: Easily create multiple replicas

---

## Core Terms
### Container Image
A **container image** is a file that contains everything needed to run an app.

### Container Registry
A **container registry** stores container images.
- Public or private

Examples:
- Docker Hub
- Quay
- Google Container Registry (GCR)

---

## Containers & Kubernetes
- Kubernetes **pulls images** from a registry
- Runs containers using a **container runtime**
- Scales replicas automatically

Kubernetes manages containers — it does **not** replace them.

---

## Container Runtimes
Popular options:
- Docker
- containerd
- Podman
- rkt
- LXD

---

## Big Picture
- Containers = **package applications**
- Kubernetes = **run and manage them at scale**

Containers made Kubernetes possible.


---
<br>



# What is Cloud Native?

## Simple Definition
**Cloud native** means building applications **designed to run in the cloud** and:
- Scale automatically
- Deploy fast
- Recover from failure without manual work

---

## Official Idea (Simplified)
Cloud native technologies help teams **build and run scalable apps** in:
- Public cloud
- Private cloud
- Hybrid cloud

---


## Core Cloud Native Concepts
- **Containers** – package apps
- **Microservices** – small, independent services
- **Declarative APIs** – say *what* you want, not *how*
- **Immutable infrastructure** – don’t fix servers, replace them
- **Service meshes** – manage service-to-service communication

---

## Why Cloud Native Matters
Old way:
- Teams worked in silos
- Slow releases (weekly/monthly)

Cloud native way:
- Dev + Ops work together
- Continuous testing & deployment
- Faster releases, fewer failures

---

## CNCF (Cloud Native Computing Foundation)
- Part of the **Linux Foundation**
- Supports cloud native projects like **Kubernetes**
- Runs **KubeCon**
- Offers certifications
- Classifies projects:
  - **Graduated** – production ready (Kubernetes)
  - **Incubating** – growing
  - **Sandbox** – experimental

---

## Big Picture
- **Containers** package apps
- **Kubernetes** runs them
- **Cloud native** is the philosophy behind it all


---
<br>




# Prerequisites

To run Kubernetes locally, you need:

- **Docker**  
  Required to build and run containers.
  [click to download]()
- **Docker Desktop**  
  Provides the Docker engine and UI needed by local Kubernetes tools.
  [click to download](https://www.docker.com/products/docker-desktop/)
- **Minikube**  
  Runs a **local Kubernetes cluster** on your system using Docker.
  [click to download](https://minikube.sigs.k8s.io/docs/start/?arch=%2Fwindows%2Fx86-64%2Fstable%2F.exe+download)
---
<br>



# Spin Up and Explore a Minikube Cluster

## Prerequisites
- Docker (or Podman) must be running
- kubectl installed
- minikube installed

---

## 1. Verify Container Runtime
Make sure Docker is running:
```bash
docker
```

If this fails, start **Docker Desktop**.

<div style="display:flex; gap:10px;"> <img src="/k8s/img/kube1.png" width="400"> </div>

---

## 2. Start Minikube Cluster

Create a local Kubernetes cluster:

```cmd
minikube start
```

This may take a few minutes.
Success message = cluster is ready.

<div style="display:flex; gap:10px;"> <img src="/k8s/img/kube2.png" width="400"> </div>


```cmd
minikube stop
minikube delete
```

**REMEMBER TO DESTROY MINIKUBE IF NOT IN USE**

---

## 3. Minikube vs kubectl

* **minikube** → creates and manages the cluster
* **kubectl** → interacts with the cluster

In cloud (AWS/GCP/Azure):

* Cloud CLI creates cluster
* kubectl is still used to manage it

---

## 4. Cluster Info

```bash
kubectl cluster-info
```

Shows:

* Control plane URL (localhost)
* Core cluster services

Error: *connection refused* → cluster not running.

<div style="display:flex; gap:10px;"> <img src="/k8s/img/kube3.png" width="400"> </div>

---

## 5. View Nodes

```bash
kubectl get nodes
```

You should see:

* 1 node named `minikube`
* Role: control-plane
* Kubernetes version

<div style="display:flex; gap:10px;"> <img src="/k8s/img/kube4.png" width="400"> </div>

---

## 6. View Namespaces

```bash
kubectl get namespaces
```

Default namespaces:

* default
* kube-system
* kube-public
* kube-node-lease

<div style="display:flex; gap:10px;"> <img src="/k8s/img/kube5.png" width="400"> </div>

---

## 7. View Pods (All Namespaces)

```bash
kubectl get pods -A
```

Shows:

* System pods
* Core Kubernetes components

<div style="display:flex; gap:10px;"> <img src="/k8s/img/kube6.png" width="500"> </div>

---

## 8. View Services

```bash
kubectl get services -A
```

Services act as **internal load balancers** for pods.

<div style="display:flex; gap:10px;"> <img src="/k8s/img/kube7.png" width="500"> </div>

---

## Summary

* You created a local Kubernetes cluster
* Explored nodes, namespaces, pods, and services
* Ready to deploy applications next


---
<br>
