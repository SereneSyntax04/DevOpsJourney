# Challenge: Quote Service Deployment

## Requirements

* Create a deployment in **quote.yml**
* Deployment name: `quote-service`
* App label: `quote-service`
* Namespace: `development`
* Container name: `quote-container`
* Replicas: 2
* Image: `datawire/quote:0.5.0`
* Container port: 8080

Optional: Test traffic using BusyBox

---

## Files:

1. [Quotes.yml](/k8s/k8sTask/task1/quote.yml)

2. [namespace.yml](/k8s/k8sTask/task1/namespace.yml)

3. [busybox.yml](/k8s/k8sTask/task1/busybox.yml)


---

## Steps

1. Create the deployment:

```bash
kubectl apply -f namespace.yml
kubectl get namespaces
kubectl apply -f quote.yml
```
<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/task1a.png" width="500"> <img src="/k8s/img/task1b.png" width="500"> </div>

<br>

2. Check pods in development namespace:

```bash
kubectl get pods -n development
```
<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/task1c.png" width="500"> </div>

3. (Optional) Test with BusyBox:

```bash
kubectl apply -f busybox.yml
kubectl get pods
```
<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/task1d.png" width="500"> </div>

```bash
kubectl get pods -n development -o wide
```
<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/task1e.png" width="500"> </div>

```powershell
kubectl exec -it <busybox-pod> -- /bin/sh
wget <pod-IP>:8080
cat index.html
```
<div style="display:flex; gap:10px; align:center"> <img src="/k8s/img/task1f.png" width="500"> </div>

---


## steps for deletion

```bash
kubectl delete -f busybox.yml
kubectl delete -f quote.yml -n development
kubectl delete -f namespace.yml
```