# Introduction to Kubernetes (K8s)

<div style="display:flex; justify-content:center; gap:20px;">
  <img src="/k8s/img/k8s.png" width="500">
</div>

<br>

[The Illustrated Childrens Guide to Kubernetes](https://www.cncf.io/wp-content/uploads/2020/08/The-Illustrated-Childrens-Guide-to-Kubernetes.pdf)


---
<br>


## 🌍 The Story Before Kubernetes

Before Kubernetes, **Docker changed everything**.

Docker allowed developers to package:

* application code
* libraries
* dependencies
* configs

into a single portable unit called a **container**.

This solved the classic problem:

> “It works on my machine but not in production.”

Containers made apps portable and fast to deploy.
For small systems → this worked great.

But when companies started running:

* hundreds of containers
* across many servers
* across multiple clouds

new problems appeared.

Running many containers manually became painful.

Teams started facing:

- **Scalability Issues** (How do you automatically increase containers when traffic spikes?)

- **Multi-Cloud Deployments** (How do you manage containers across AWS + Azure + on-prem together?)

- **Security & Resource Management** (Which container gets how much CPU/RAM?
How do you prevent overload?)

- **Rolling Updates & Zero Downtime** (How do you update apps without breaking live users?)


## 🎯 This Is Why Kubernetes Was Created

Kubernetes was built to **manage containers at scale**.

Instead of humans managing containers manually, Kubernetes became the **automation brain** behind container infrastructure.

> Containers package apps.
> Kubernetes runs and manages them intelligently.

---

# 🚢 What is Kubernetes (K8s)?

**Kubernetes (K8s)** is an **open-source container orchestration platform** that automates:

* Deployment
* Scaling
* Load balancing
* Health checks
* Updates
* Recovery from failures

K8s = **K + 8 letters + s** → Kubernetes → K8s


# 🏛️ Kubernetes Origin

* Developed by **Google**
* Inspired by internal systems:

  * Borg
  * Omega
* Released: **2014**
* Open-sourced: **2015**
* Donated to **CNCF (Cloud Native Computing Foundation)**
* Name meaning: Greek word for **Helmsman / Pilot**

---

# ⚙️ Core Features of Kubernetes

## ✅ Automated Scheduling

Places containers on the best available machines automatically.

## 🔁 Self-Healing

If a container crashes:

* restart it
* replace it
* move it to another node

No human needed.

## 🔄 Rollouts & Rollbacks

Update apps safely:

* gradual rollout
* instant rollback if something breaks

## 📈 Scaling & Load Balancing

Traffic ↑ → Pods ↑
Traffic ↓ → Pods ↓

## 💻 Resource Optimization

Controls CPU & memory usage per container.

---

# 🏗️ Why Microservices Made Kubernetes Necessary

## Old Style → Monolithic Apps

In the past, applications were built using a monolithic architecture, where everything was interconnected and bundled into one big codebase. This made updates risky for example, if you wanted to change just the payment module in an e-commerce app, you had to redeploy the entire application. A small bug could crash the whole system.

Problem:

* Small change → redeploy whole app
* One bug → entire app crash
* Hard to scale individual parts

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/k8s/img/monolithic.webp" width="500">
</div>


## New Style → Microservices

To overcome this, the industry moved toward microservices, where each feature (like payments, search, or notifications) is built and deployed independently. This made applications more flexible and scalable.

Benefits:

* Deploy independently
* Scale independently
* Fail independently


## 😵 New Challenge Appeared

Now instead of 1 app → you manage **200+ containers**

Questions:

* Where should each run?
* How many replicas?
* What if one fails?
* How to connect them?

With microservices came a new challenge instead of running one big app, companies now had to manage hundreds or thousands of small containerized services. Containers solved the packaging problem, but without a way to orchestrate them, things got messy. That’s where Kubernetes came in acting like a smart manager that automates deployment, scaling, and coordination of all those microservices.

---

# Kubernetes Core Terminologies — 

Think of **Kubernetes like a company that runs applications**.
Each component has a clear role — management, workers, networking, storage, and configuration.


## 🌐 Cluster (The Whole Company)

A **Kubernetes Cluster** is the full system that runs your applications.

It contains:

* Control Plane (decision makers)
* Worker Nodes (do the actual work)

Without a cluster → nothing runs.


## 🧠 Control Plane (Master Node / Brain)

The **Control Plane** is the brain of Kubernetes.

It:

* decides where Pods should run
* schedules workloads
* tracks cluster state
* handles scaling decisions

You don’t run apps here — you **control** apps from here.


## 🖥️ Node (Worker Machine)

A **Node** is a machine (VM or physical server) that runs your apps.

Each worker node contains:

* Container runtime (containerd / Docker)
* Kubelet agent
* Kube-proxy networking

Think: **office building where employees work**

---

## Pod (Smallest Deployable Unit)

A **Pod** is the smallest unit you deploy in Kubernetes.

It contains:

* one or more containers
* shared network
* shared storage

Containers inside a Pod:

* talk via localhost
* are tightly coupled
* start/stop together

Think: **Pod = one employee desk with tools**


## 📦 Deployment (Pod Manager)

A **Deployment** manages Pods for your application.

You declare:

```
I want 3 replicas of my app running
```

Deployment ensures:

* Pods are created
* Pods are updated safely
* Rollouts & rollbacks work

Think: **HR manager for Pods**


## 👥 ReplicaSet (Replica Enforcer)

A **ReplicaSet** ensures the required number of Pods are always running.

Example:

```
Desired = 3 Pods
1 crashes → ReplicaSet creates new one
```

Usually you don’t create ReplicaSets directly — Deployment creates them.

Think: **Attendance checker**


## 🔗 Service (Stable Network Identity)

Pods are temporary — their IPs change.

A **Service** gives:

* stable IP
* stable DNS name
* load balancing

So other apps can reliably connect.

Think: **company phone number that never changes**


## 🚪 Ingress (External Entry Gate)

**Ingress** manages external access to services.

It:

* routes HTTP/HTTPS traffic
* acts like reverse proxy
* supports domain routing

Example:

```
/api → backend service
/shop → frontend service
```

Think: **company reception desk**


## ⚙️ ConfigMap (Non-Secret Settings)

A **ConfigMap** stores configuration data separately from app code.

Examples:

* feature flags
* environment configs
* URLs
* ports

Benefits:

* change config without rebuilding image
* environment-specific settings

Think: **settings file outside the app**

⚠️ Not for passwords.


## 🔐 Secret (Sensitive Data Store)

A **Secret** stores sensitive information:

* passwords
* API keys
* tokens
* certificates

More secure than ConfigMap.

Think: **locked vault**


## 💾 Persistent Volume (PV) — Durable Storage

Pods are temporary — storage inside them is lost on restart.

**Persistent Volume (PV)** provides:

* durable storage
* survives Pod deletion
* reusable across Pods

Think: **external hard drive**


## 🤖 Kubelet (Node Agent)

**Kubelet** runs on every worker node.

It:

* talks to control plane
* starts containers
* monitors Pods
* reports status

Think: **floor supervisor**


## 🌐 Kube-proxy (Cluster Networking)

**Kube-proxy** handles networking rules.

It:

* routes traffic to Pods
* enables Service load balancing
* manages internal network paths

Think: **internal traffic controller**


# 🧠 One-Shot Revision Table

| Term          | Simple Meaning           |
| ------------- | ------------------------ |
| Cluster       | Full Kubernetes system   |
| Control Plane | Brain / decision maker   |
| Node          | Worker machine           |
| Pod           | Smallest deployable unit |
| Deployment    | Manages Pods             |
| ReplicaSet    | Maintains Pod count      |
| Service       | Stable network access    |
| Ingress       | External HTTP entry      |
| ConfigMap     | Non-secret config        |
| Secret        | Sensitive config         |
| PV            | Persistent storage       |
| Kubelet       | Node agent               |
| Kube-proxy    | Network router           |

---
