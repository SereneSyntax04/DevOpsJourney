# Kubernetes Local Setup with Minikube (Windows)

## Why Minikube?
Installing Kubernetes from scratch is painful.
Minikube solves this by running a **pre-configured Kubernetes cluster inside a VM** on your local machine.

Perfect for:
- Learning Kubernetes
- Local development
- Hands-on practice before cloud (EKS / AKS / GKE)

---

## Tools Required

### 1. Minikube
- Runs a single-node Kubernetes cluster
- Node acts as both:
  - Control Plane (master)
  - Worker node

### 2. kubectl
- Command-line client for Kubernetes
- Used to interact with the cluster
- Installed separately from Minikube

---

## Installation (Windows)

### 1. Install Minikube (Windows) and Verify:

- [Refer k8s.md file for detailed steps](/k8s/k8s.md)

```powershell
minikube version
```

---

### 2. Start Local Kubernetes Cluster

```powershell
minikube start
```

---

### 3. Verifying Cluster

#### Check Kubernetes versions

```powershell
kubectl version
```

---

### 4. Stopping the Cluster

```powershell
minikube stop
```




---
<br>







# 