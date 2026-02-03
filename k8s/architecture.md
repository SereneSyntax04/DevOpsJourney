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


## Virtual Network 

Virtual Network is the component of Kubernetes which enables the worker nodes and the master nodes to talk to each other. Virtual Network actually turns all the nodes inside of the cluster into one powerful machine that has the sum of all the resources of individual nodes.


## 🔲 Pod (Smallest Deployable Unit)

A **Pod** is the smallest unit you deploy in Kubernetes.
One very important feature of Pod is that it is ephemeral. This means that if a Pod fails, then Kubernetes can automatically create its new replica.

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

A **Deployment** manages Pods for your application.<br>
Deployment are the Kubernetes component that manages the replication and lifecycle of the Pods in the Kubernetes Cluster.

In our current example, what happens if our application Pod dies, crashes or I have to restart the Pod because I built a new container image? What happens is that we will have a downtime where the users will not be able to reach our application. This is a terrible thing if it happens in production.

Deployment is another abstraction on top of Pods which makes it more convenient to interact with the Pods, replicate them and do some other configuration.
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



##  IP addresses

In Kubernetes, inside the virtual network, each Pod gets its own IP address (note that Pod gets the IP address not the container) and each Pod can communicate with each other using that IP address.

* Pods communicate with each other using these **internal cluster IPs**.
* These IPs are **not public** — only valid inside the cluster network.
* Pods are **ephemeral** — if a Pod crashes or is recreated, it gets a **new IP address**.
* Because Pod IPs change, directly using Pod IPs is unreliable.
* To solve this, Kubernetes uses a **Service**, which provides a **stable IP/DNS name** that points to Pods.

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/k8s/img/ip.webp" width="500">
</div>


## 🔗 Service (Stable Network Identity)

Service is basically a static IP address or permanent IP address that can be attached to the Pod. 
That means that "my app" will have its own Service and database Pod will have its own Service.

A **Service** gives:

* stable IP
* stable DNS name
* load balancing

So other apps can reliably connect.

Think: **company phone number that never changes**

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/k8s/img/services.webp" width="500">
</div>

Now we want our application to be accessible through a browser and for this we would have to create an **external service.**
- Exposes your app to the outside world (browser/users).
- Used for frontend or public APIs.
- Example: http://my-app-service-ip:port

But we would not want our database to be open to the public requests (because of security reasons). So for that we would create an **internal service**
- Only accessible inside the cluster.
- Used for databases or backend services.
- More secure — not publicly exposed.
- Example: http://db-service-ip:port

**Raw service IP + port is not user-friendly for production.**

usually you will want your URL to look more efficient, some-what like-- <br>
https://my-app.com/ <br>
And for that we use **Ingress.**


## 🚪 Ingress (External Entry Gate)

**Ingress** manages external access to services. simply- <br>
The role of Ingress is that instead of Service, the request goes first to Ingress and it does the forwarding then to the Service.

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/k8s/img/ingress.webp" width="500">
</div>

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

A **ConfigMap** stores configuration data separately from app code. Simply- <br>
Config Map is the external configuration to your application. Config Map usually contains configuration data like URLs of database or URLs of some other services that we are using.

Benefits:

* change config without rebuilding image
* environment-specific settings

<br>

* Pods talk to other components (like DB) using a **Service endpoint**.

* If the DB service name/URL changes and it’s hardcoded in the app:

  * You must rebuild image
  * Push new version
  * Redeploy Pods ❌ (too much work)

* **ConfigMap solves this problem**

  * Stores **non-sensitive configuration data** (URLs, service names, ports, flags).
  * Config is kept **outside the container image**.
  * Pod reads config from ConfigMap (env vars or mounted files).

* If config changes:

  * Update ConfigMap ✅
  * No need to rebuild the image.

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/k8s/img/configMap.webp" width="500">
</div>

## 🔐 Secret (Sensitive Data Store)

Secret is just like config map but the difference is that it's used to store secret data credentials and it stores this data not a plain text format but in base64 encoded format.

* Keeps sensitive config **separate from container image**.

* Pods can access Secrets:

  * As **environment variables**
  * As **mounted files (volumes)**

* If credentials change:

  * Update Secret ✅
  * No need to rebuild image.


## 💾 Persistent Volume (PV) — Durable Storage

Pods are temporary — storage inside them is lost on restart. <br>
A Volume in Kubernetes is a data storing feature with the help of which we can store data that is persistent and can be accessed by containers in a Kubernetes pod.

We would want your database data or log data to be persisted in the long-term and that is why we have the Kubernetes component called Volumes.

**Persistent Volume (PV)** provides:

* durable storage
* survives Pod deletion
* reusable across Pods

That storage could be either on a local machine (meaning on the same server node where the Pod is running) or it could be on a remote storage (meaning outside of the Kubernetes cluster). Now when the database Pod or the Container gets restarted, all the data will be there persisted.


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
