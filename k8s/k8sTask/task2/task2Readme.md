# Expose your application to the internet with a LoadBalancer

## 🚩 Problem

So far, the application is **only accessible inside the Kubernetes cluster** (via a busybox pod).
That’s useless for real users on the internet.

👉 We need a way to expose it **outside the cluster**.

---

## 🧠 Solution: Kubernetes Service

A **Kubernetes Service** acts as a **stable entry point** to access pods.

Why it’s needed:

* Pods are **ephemeral** (IP changes all the time)
* Services provide:

  * **Stable IP**
  * **Load balancing**
  * **Traffic routing to pods**

---

## 🌐 LoadBalancer Service

A **LoadBalancer service**:

* Gets a **public IP address**
* Routes traffic from the internet → pods
* Ideal for production on cloud platforms (AWS, GCP, Azure)

Key features:

* **Public IP** → accessible from internet
* **Static IP** → doesn’t change when pods restart

---

## 📄 Service YAML Example

```yaml
apiVersion: v1
kind: Service
metadata:
  name: demo-service
  namespace: development
spec:
  type: LoadBalancer
  selector:
    app: pod-info
  ports:
    - port: 80
      targetPort: 3000
```

### What matters here 👇

#### 1️⃣ Selector

```yaml
selector:
  app: pod-info
```

* Service sends traffic to **pods with this label**
* Must match the label in your Deployment
* ❌ If labels don’t match → service breaks silently

#### 2️⃣ Ports

```yaml
port: 80
targetPort: 3000
```

* `port`: external service port (default HTTP)
* `targetPort`: container’s port
* Users hit port **80**, app runs on **3000**

#### 3️⃣ Type

```yaml
type: LoadBalancer
```

* Exposes the app externally
* One of **three service types**

---

## 🔢 Types of Kubernetes Services

| Type         | Purpose                      |
| ------------ | ---------------------------- |
| ClusterIP    | Internal-only (default)      |
| NodePort     | Exposes via node IP + port   |
| LoadBalancer | Public IP via cloud provider |

---

## 🧪 Using LoadBalancer with Minikube

Since Minikube runs **locally**, it doesn’t get a real public IP.

### Step 1️⃣ Start tunnel

```cmd
minikube tunnel
```
<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/task2a.png" width="400"> </div>


⚠️ Requires **admin/sudo access**

### Step 2️⃣ Create the service

```bash
kubectl apply -f namespace.yml
kubectl apply -f secure-deployment.yml
kubectl apply -f service.yml
```
<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/task2b.png" width="400"> </div>


### Step 3️⃣ Get service IP

```bash
kubectl get services -n development
kubectl get pods -n development
```

You’ll see:

* **Cluster IP** (internal)
* **External IP** → usually `127.0.0.1` in Minikube

<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/task2c.png" width="400"> <img src="/k8s/img/task2d.png" width="400"> </div>


---

## 🌍 Access from Browser

* Copy the **External IP**
* Open browser → paste IP
* If tunnel asks for password → enter it
* 🎉 App becomes accessible

<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/task2e.png" width="400"> </div>


---

## ⚠️ Important Notes

* `127.0.0.1` is **not public internet**
* This happens because:

  * Minikube ≠ cloud provider
* On AWS / GCP / Azure:

  * You get a **real public IP**

---

## 🛑 Cleanup

Stop the tunnel:

```cmd
Ctrl + C
```


```bash
kubectl delete -f service.yml -n development
kubectl delete -f secure-deployment.yml
kubectl delete -f namespace.yml 
```


---


