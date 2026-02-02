# Experiment k8s with minikube

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

What happens:

* A VM is created
* Kubernetes control plane starts
* Networking + container runtime are configured

<div style="display:flex; gap:10px;"> <img src="/k8s/img/kube2.png" width="400"> </div>

```cmd
minikube stop
minikube delete
```

Why stop it?

* Saves CPU, RAM, and battery
* Cluster state is preserved

Restart anytime:

```powershell
minikube start
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
