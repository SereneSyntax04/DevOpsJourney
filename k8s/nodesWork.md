
# How Kubernetes Control Plane and Nodes Work Together

## High-Level Idea

```
You (kubectl)
   ↓
Control Plane (decision & state)
   ↓
Worker Node (execution)
```

Kubernetes works in **loops**, not one-time actions.

---

## Step-by-Step Pod Creation Flow

<div style="display:flex; gap:10px;"> <img src="/k8s/img/timeseqDiag.png" width="600"> </div>


### 1️⃣ You send a request

```bash
kubectl apply -f deployment.yaml
```

* `kubectl` uses **kubeconfig** for authentication
* Sends HTTP request to **kube-apiserver**

---

### 2️⃣ API Server stores desired state

* kube-apiserver:

  * Validates request
  * Stores Deployment spec in **etcd**

> etcd now knows: *"User wants these pods"*

---

### 3️⃣ Controller Manager reacts

* kube-controller-manager detects new Deployment
* Creates:

  * ReplicaSet
  * Pod objects (without node assigned)

---

### 4️⃣ Scheduler assigns a node

* kube-scheduler finds Pods with **no node**
* Chooses best worker node based on:

  * CPU / memory
  * labels
  * taints & tolerations
* Updates Pod → **nodeName**
* API server saves this to etcd

---

### 5️⃣ Kubelet picks up the Pod

* kubelet on the chosen node:

  * Watches API server
  * Sees Pod assigned to itself

---

### 6️⃣ Container runtime creates containers

* kubelet:

  * Pulls container image
  * Uses container runtime (containerd / CRI-O)
  * Starts containers inside the Pod

---

### 7️⃣ Status is reported back

* kubelet reports Pod status (Running / Failed)
* kube-apiserver updates state in **etcd**

---

> kubectl sends a request to the API server, controllers create pod objects, the scheduler assigns a node, the kubelet runs the pod using the container runtime, and the cluster state is stored in etcd.


---
<br>


