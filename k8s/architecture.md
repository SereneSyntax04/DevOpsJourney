# Kubernetes

<div style="display:flex; gap:10px;"> <img src="/k8s/img/apiserver.png" width="500"> </div>

## 1. Kubernetes Basics

### Cluster

* A **Kubernetes cluster** = Control Plane + Worker Nodes
* It runs and manages containerized applications

### Node

* A **machine (VM or physical)** in the cluster
* Two types:

  * **Control Plane node** (brain)
  * **Worker node** (muscle)

---

## 2. Control Plane (The Brain 🧠)

> If Kubernetes were an airport, the control plane is the **air traffic control tower**.

### kube-apiserver (MOST IMPORTANT)

* Entry point of Kubernetes
* Exposes Kubernetes **REST API**
* All tools talk to this:

  * `kubectl`
  * CI/CD
  * Controllers

**Truth:** If API server is down → cluster is unusable

---

### etcd (Cluster Memory)

* Distributed **key‑value database**
* Stores **entire cluster state**:

  * Pods
  * Deployments
  * Secrets
  * ConfigMaps

**Rule:**

* Only kube‑apiserver talks to etcd
* Lose etcd → lose cluster state

---

### kube-scheduler (Matchmaker)

* Finds **new pods without a node**
* Decides **which node** a pod should run on
* Considers:

  * CPU / Memory
  * Node labels
  * Taints & tolerations

**Note:** Scheduler does *not* create pods

---

### kube-controller-manager (Supervisor)

* Runs control loops continuously
* Ensures **desired state = actual state**

Examples:

* Deployment controller
* Node controller
* ReplicaSet controller

> “You want 3 pods, I see only 2 → I’ll create one more.”

---

### cloud-controller-manager (Cloud Only ☁️)

* Integrates Kubernetes with cloud providers
* Manages:

  * Load balancers
  * Volumes
  * Node lifecycle

Used in:

* AWS EKS
* GCP GKE
* Azure AKS

---

## 3. Worker Node Components (The Muscle 💪)

### kubelet (MOST IMPORTANT on node)

* Agent running on every node
* Talks to API server
* Responsibilities:

  * Starts pods
  * Monitors containers
  * Reports node health

**If kubelet stops → pods stop being managed**

---

### kube-proxy (Networking Guy)

* Handles **Service networking**
* Maintains iptables / IPVS rules
* Enables:

  * Pod ↔ Pod communication
  * Service → Pod routing

**Without kube‑proxy → Services break**

---

### Container Runtime

* Actually runs containers
* Kubernetes uses **CRI** (Container Runtime Interface)

Common runtimes:

* containerd (default)
* CRI‑O

> Docker is NOT required anymore

---

## 4. Core Kubernetes Objects (YOU MUST KNOW)

### Pod

* Smallest deployable unit
* One or more containers
* Shares:

  * IP
  * Storage
  * Network

> Kubernetes never runs containers directly—only Pods

---

### Deployment

* Manages **stateless applications**
* Provides:

  * Scaling
  * Rolling updates
  * Rollbacks

Creates:

* ReplicaSet → Pods

---

### ReplicaSet

* Ensures **N number of pods** are running
* Usually managed by Deployments

---

### StatefulSet

* For **stateful applications**
* Guarantees:

  * Stable pod names
  * Stable storage
  * Ordered startup

Used for:

* Databases
* Kafka
* Elasticsearch

---

### DaemonSet

* Runs **one pod per node**

Used for:

* Log collectors
* Monitoring agents
* Security tools

---

### Job

* Runs a task **once**
* Exits after completion

Examples:

* DB migration
* Backup

---

### CronJob

* Scheduled Jobs
* Like Linux `cron`

---

## 5. Networking & Access

### Service

* Stable endpoint for pods
* Pods change IPs, Services don’t

Types:

* ClusterIP (internal)
* NodePort
* LoadBalancer
* ExternalName

---

### Ingress

* HTTP/HTTPS routing (Layer 7)
* Routes traffic using:

  * Hostnames
  * Paths

Requires **Ingress Controller**:

* NGINX
* AWS ALB

---

### CNI (Container Network Interface)

* Provides pod networking

Popular CNIs:

* Calico
* Flannel
* Cilium

**No CNI → no pod communication**

---

## 6. Storage

### Volume

* Pod‑level storage
* Dies with pod

---

### PersistentVolume (PV)

* Actual storage resource

---

### PersistentVolumeClaim (PVC)

* Request for storage by pod

> Pods use PVC, not PV directly

---

## 7. Config & Security

### ConfigMap

* Non‑sensitive configuration
* Used as:

  * Environment variables
  * Config files

---

### Secret

* Sensitive data
* Passwords, tokens, keys

⚠️ Base64 encoded (not encrypted by default)

---

### ServiceAccount

* Identity for pods
* Used to access Kubernetes API

---

### RBAC (Permissions)

* Controls **who can do what**

Objects:

* Role / ClusterRole
* RoleBinding / ClusterRoleBinding

---

## 8. Scheduling & Organization

### Namespace

* Logical separation

Common namespaces:

* kube-system
* default
* dev / test / prod

---

### Labels & Selectors

* Key‑value metadata
* Used for grouping and selection

---

## 9. kubectl Essentials

```bash
kubectl get pods
kubectl describe pod <name>
kubectl logs <pod>
kubectl apply -f file.yaml
kubectl delete -f file.yaml
kubectl api-resources
```

---

## 10. Managed Kubernetes (Reality Check)

### EKS / GKE / AKS

* Control plane is **hidden**
* Cloud provider manages:

  * API server
  * etcd
  * Controllers

You manage:

* Worker nodes
* Applications

---

## Summary

* **kubectl** → talks to API server
* **API server** → controls everything
* **etcd** → cluster memory
* **kubelet** → runs pods
* **kube‑proxy** → networking
* **Deployment** → manages pods
