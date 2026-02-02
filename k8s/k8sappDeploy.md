# YAML Basics (for Kubernetes)

## Why YAML matters

* Used heavily in **Kubernetes**, **IaC**, and **GitOps**
* Stores the **desired state** of your cluster
* Human‑readable and portable (like JSON, XML)

---

## What is YAML?

* **YAML** = *YAML Ain't Markup Language*
* A **data serialization language**
* Designed for humans, not machines

---

## File extensions

* `.yaml` or `.yml`
* Both are valid (team decides)

---

## Basic YAML syntax

### 1. Document start

```yaml
---
```

* Three dashes = start of a document
* One file can have multiple documents

---

### 2. Comments

```yaml
# This is a comment
```

* Starts with `#`
* Ignored by programs

---

### 3. Key–Value pairs

```yaml
name: Serene Syntax
```

* Colon `:` separates key and value

---

### 4. Sequences (Lists)

```yaml
courses:
  - Kubernetes Foundations
  - Docker Foundations
```

* Dash `-` for each item

---

### 5. Maps (Nested objects)

```yaml
jobs:
  company: Scitara
  years: 1
  titles:
    - Cloud intern
    - Devops intern under ESG (enterprise solutions group)
```

* Indentation defines structure

---

## ⚠️ Common mistakes

* ❌ **Wrong indentation** (most common error)
* ❌ Mixing tabs and spaces

Tip: Always use **spaces**, not tabs

---

## Validate your YAML

* Use tools like [yamlchecker.com](https://yamlchecker.com/)
* Helps catch indentation and syntax errors fast

---

## Kubernetes context

* Kubernetes objects are written as **YAML manifests**
* YAML lets you:

  * Declare infrastructure
  * Track changes in Git
  * Use GitOps workflows



## example.yml
[Example.yml file](/k8s/yamlfiles/example.yml)

---
<br><br>












> this file uses **.yml files** which are stored in [yamlfiles folder](/k8s/yamlfiles/)


# Creating Kubernetes Namespaces

## Why namespaces?

* Namespaces help **organize and isolate workloads**
* Common use case: separate **dev** and **prod** in the same cluster
* Makes Kubernetes manageable as things grow

---

## Default namespaces

Check existing namespaces:

```bash
kubectl get namespaces
```

Typical defaults:

* `default`
* `kube-system`
* `kube-public`
* `kube-node-lease`

<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/namespaces.png" width="500"> </div>

---

## Namespace manifest (YAML)

A namespace manifest is **very simple**.
Only the `name` really matters.

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: development
```

Save this as `namespace.yaml`

---

## Create the namespace

```bash
kubectl apply -f namespace.yaml
```

Verify:

```bash
kubectl get namespaces
```

You should now see `development`

---

## Multiple namespaces in one file

YAML allows **multiple documents** using `---`

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: development
---
apiVersion: v1
kind: Namespace
metadata:
  name: production
```

Apply again:

```bash
kubectl apply -f namespace.yaml
```

Now both namespaces exist 👍

<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/namespaceyaml.png" width="500"> <img src="/k8s/img/namespaceyml.png" width="500"> </div>

---

## Delete namespaces

```bash
kubectl delete -f namespace.yaml
```

Deletes **all resources** defined in the file

<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/delete.png" width="500"> </div>

---

## Kubernetes context

* Namespaces isolate:

  * Applications
  * Microservices
  * Environments (dev / prod)
* Essential for **real-world clusters**


## namespace.yml
[namespace.yml file](/k8s/yamlfiles/namespace.yml)

---
<br><br>















# Deploying an Application (Kubernetes Deployment)

## Why Deployments?

* Kubernetes is built for **high availability**
* Instead of running single Pods, we use **Deployments**
* Deployments ensure:

  * Multiple replicas
  * Auto-replacement if a Pod dies

---

## Core concepts

* **Pod**: Runs your container
* **Deployment**: Manages Pods for you
* **Replica**: Number of Pods running at the same time

---


## Before deploying

Make sure the namespace exists:

```bash
kubectl get namespaces
```

If not present:

```bash
kubectl apply -f namespace.yaml
```
<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/check.png" width="500"> <img src="/k8s/img/apply.png" width="500"></div>

---

## Create the deployment

```bash
kubectl apply -f deployment.yaml
```

<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/deploy1.png" width="500"> </div>

---

## Verify deployment

### Check deployments

```bash
kubectl get deployments -n development
```
<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/deploy2.png" width="500"> </div>

### Check Pods

```bash
kubectl get pods -n development
```

You should see **3 Pods running**

<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/deploy3.png" width="500"> </div>

---

## Proving high availability

Delete one Pod:

```bash
kubectl delete pod <pod-name> -n development
```
<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/deploy4.png" width="500"> </div>

Check again:

```bash
kubectl get pods -n development
```

<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/deploy5.png" width="500"> </div>

➡️ Kubernetes **automatically creates a new Pod**


---

## What just happened?

* Deployment noticed replicas < 3
* New Pod created instantly
* Desired state maintained



## deployment.yml
[deployment.yml file](/k8s/yamlfiles/deployment.yml)

---
<br><br>















# Checking Pod Health Using Event Logs

## Why Pod health matters

* Pods can fail **very early** in their lifecycle
* Common reasons:

  * Image not found
  * Not enough node resources
  * App crashes due to config errors
* Kubernetes records **events** to help you debug

---

## Step 1: List Pods

First, find the Pod you want to inspect.

```bash
kubectl get pods -n development
```
<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/deploy6.png" width="500"> </div>

Copy the name of any Pod

---

## Step 2: Describe the Pod

Use `kubectl describe` to see detailed info.

```bash
kubectl describe pod <pod-name> -n development
```

<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/deploy7.png" width="500"> </div>

---

## What you’ll see

* Pod metadata (name, namespace, labels)
* Container details
* Node scheduling info

Some of this matches your **Deployment YAML**

---

## Event logs (most important part)

Scroll to the **bottom** of the output.

### Healthy Pod

You may see:

* `Scheduled`
* `Pulled image`
* `Created container`
* `Started container`

Or **no events at all** (this is good)

---

### Unhealthy Pod

You might see errors like:

* ImagePullBackOff
* CrashLoopBackOff
* FailedScheduling

These messages tell you **what went wrong**

---

## Important rule of thumb

* Most Pod issues happen in the **first 1 minute**
* If no recent events → Pod is healthy
* Kubernetes stops logging once things are stable


---
<br><br>















# Checking Your Application with BusyBox

## Why BusyBox?

* After deploying an app, you must **verify it actually works**
* BusyBox = *Swiss Army knife* of Linux
* Includes tools like `wget`, `cat`, `date`, `whoami`
* Perfect for **debugging inside a Kubernetes cluster**

---

## What we’re doing (big picture)

* Deploy a **BusyBox Pod**
* Use it to make an **HTTP request** to our app
* Confirm the app responds correctly

---

## Step 1: Deploy BusyBox

BusyBox runs in the **default namespace** with 1 replica.

```bash
kubectl apply -f busybox.yaml
```
<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/deploy8.png" width="500"> </div>

Check that it’s running:

```bash
kubectl get pods
```
<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/deploy9.png" width="500"> </div>

(No `-n` needed → defaults to `default` namespace)

---

## Step 2: Get Pod IP of the application

In a **new terminal tab**, run:

```bash
kubectl get pods -n development -o wide
```

* `-o wide` shows extra details
* Copy the **Pod IP address**
<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/deploy10.png" width="500"> </div>

---

## Step 3: Exec into BusyBox (use cmd for windows)

Get inside the BusyBox container:

```bash
kubectl exec -it <busybox-pod-name> -- /bin/sh
```

What this means:

* `exec` → run a command inside a container
* `-it` → interactive terminal
* `/bin/sh` → shell inside BusyBox

---

## Step 4: Test connectivity using wget

Inside BusyBox:

```bash
wget <POD-IP>
```
<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/deploy11.png" width="600"> <img src="/k8s/img/deploy12.png" width="600"> </div>

❌ This fails because:

* Default port = `80`
* App is running on **port 3000**

Correct command:

```bash
wget <POD-IP>:3000
```
<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/deploy13.png" width="600"> </div>

---

## Step 5: Verify response

BusyBox saves output to a file:

```bash
cat index.html
```
<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/deploy14.png" width="600"> </div>

You should see:

* JSON output
* Pod environment variables

This confirms your app is working ✅

---

## Exit BusyBox

```bash
exit
```

---

## Key takeaways

* BusyBox helps test apps **inside the cluster**
* Useful when app is **not exposed externally**
* `kubectl exec` ≈ SSH into a container
* Pod IP + correct port is critical

---
<br><br>















# Viewing Application Logs

## Why check logs?

* After deploying, you want to **see what your app is doing**
* Logs help with **debugging** and monitoring activity

---

## Step 1: List Pods

Find the pod you want to inspect:

```bash
kubectl get pods -n development
```

Copy the pod name you want to check.

---

## Step 2: View logs

Run:

```bash
kubectl logs <pod-name> -n development
```

* Prints the application logs
* Useful for **debugging HTTP requests, errors, or events**
* If you ran a `wget` request from BusyBox, you can check logs for that activity

<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/deploy15.png" width="600"> </div>

---
<br><br>















# step-by-step deletion sequence

## Step A: Delete BusyBox (default namespace)

```bash
kubectl delete -f busybox.yml
```

---

## Step B: Delete Deployment (development namespace)

```bash
kubectl delete -f deployment.yml -n development
```

---

## Step C: Delete Namespace

```bash
kubectl delete -f namespace.yml
```


---