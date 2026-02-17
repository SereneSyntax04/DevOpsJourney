# 📌 Case Study: Understanding exit code 137 - OOMkilled

Prepared by: Shrushti Shrivastav| Devops intern at Scitara| February 2026

---

# 🚨 What is OOMKill?

**OOMKill (Out Of Memory Kill)** happens when a system or Kubernetes node runs out of memory and the Linux kernel forcibly terminates a process to protect the system from crashing.

In Kubernetes:

* Each container has memory limits
* If a container exceeds its memory limit → it gets **OOMKilled**
* The pod restarts automatically (if restart policy allows)

This is managed by the Linux OOM Killer inside the kernel.

In simple words:<br>
“Your app used more RAM than allowed, so the system killed it to stay alive.”

---

# 💀 What is Exit Code 137?

**Exit Code 137 = Process killed using SIGKILL (Signal 9)**
This means the container was forcefully terminated by the system, usually due to high memory usage (OOM - Out Of Memory).

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/casestudy/img/code137.webp" width="400">
</div>

Formula:

```
137 = 128 + 9 (SIGKILL)
```

Meaning:

* 128 → Base signal exit
* 9 → SIGKILL signal (forced kill)

In Kubernetes:

```bash
kubectl describe pod <pod-name>
```

You may see:

```
Last State: Terminated
Reason: OOMKilled
Exit Code: 137
```

This confirms the container was forcefully terminated due to memory exhaustion.

Common causes:
- Memory leaks in application
- Improper resource limits
- Sudden traffic spikes
- Large batch jobs consuming memory

---

# 🔍 Why OOMKill is Critical in Observability

OOMKills are **HIGH-SEVERITY production signals** because they indicate:

| Impact Area     | Why It’s Dangerous                |
| --------------- | --------------------------------- |
| Reliability     | Application crashes repeatedly    |
| Performance     | Latency spikes before crash       |
| User Experience | Downtime & failed requests        |
| Cost            | Autoscaling waste due to restarts |
| Hidden Bugs     | Memory leaks go unnoticed         |

From an observability perspective, OOMKill is not just a crash —
it is a **symptom of deeper memory behavior issues**.

Key Observability Signals:

* Memory usage trends
* Container restarts
* Pod lifecycle events
* Node memory pressure
* Garbage collection behavior (for JVM/Node apps)

---

# 📚 Real-World Case Study: Kubernetes Pod OOMKilled

## 🏢 Scenario

A microservice deployed in Kubernetes starts restarting randomly during peak traffic.

### Symptoms Observed

* Sudden pod restarts
* Exit Code 137 in logs
* Increased latency before crashes
* No application error logs

### Investigation Step 1: Check Pod Status

```bash
kubectl get pods
```

Output:

```
my-app-7c9f   0/1   OOMKilled   5 (10m ago)
```

### Step 2: Describe the Pod

```bash
kubectl describe pod my-app-7c9f
```

Observation:

```
Reason: OOMKilled
Exit Code: 137
Memory Limit: 512Mi
```

### Step 3: Check Metrics in Observability Tool (SigNoz)

Metrics to inspect:

* container.memory.usage
* container.memory.limit
* container.restart.count

Graph insight:

```
Memory Usage → Gradually increases → Hits limit → Kill → Restart
```

Root Cause:

**Hidden memory leak in background worker + low memory limit (512Mi)**

---

# 🧩 How to Understand OOMKill 

## 1️⃣ Memory Limit vs Memory Usage

If:

```
Memory Usage > Memory Limit → OOMKill
```

Important Kubernetes fields:

```yaml
resources:
  requests:
    memory: "256Mi"
  limits:
    memory: "512Mi"
```

---

## 2️⃣ Check Node-Level Memory Pressure

Sometimes the node itself runs out of memory:

```bash
kubectl top nodes
kubectl top pods
```

If node memory is exhausted → Kubernetes may evict pods.

---

## 3️⃣ Identify the OOMKilled Container

```bash
kubectl get pod <pod> -o jsonpath='{.status.containerStatuses[*].lastState}'
```

---

# 🧠 Hidden Memory Leaks (The Silent Killer)

One of the most dangerous causes of OOMKill is:

**Gradual memory leak that is not visible immediately.**

Common leak sources:

* Unclosed DB connections
* Infinite caching
* Large in-memory queues
* Goroutine leaks (Go apps)
* Improper object retention (Java/Python)

Behavior Pattern:

```
Memory slowly increases over hours → sudden OOMKill → restart loop
```

This is why observability tools are crucial.

## IMPORTANT: REFER THIS FOR YOUR SETUP TO DETECT LATEST OOMKILLED AND AVOID CACHE/NOISE

- [📌 Implementing OOMKilled Detection Alerting in Kubernetes Using SigNoz
](/observability/oomkilled.md)

---

# 📊 Detecting OOMKill Early Using Observability (SigNoz)

Instead of reacting AFTER OOMKill, we should detect **prior risk signals**.

## Key Metrics to Monitor

Recommended metrics:

* `container.memory.usage`
* `container.memory.limit`
* `k8s.pod.restart.count`
* `k8s.container.status.last_terminated_reason`

Example Query (Conceptual):

```
memory_usage / memory_limit > 0.80
```

This gives early warning at 80% usage before actual crash.

---

## 🚨 Smart Alert Strategy (Best Practice)

| Alert Level | Condition          | Purpose            |
| ----------- | ------------------ | ------------------ |
| Warning     | > 70% Memory Usage | Early risk         |
| Critical    | > 90% Memory Usage | Immediate action   |
| Incident    | OOMKilled Event    | Post-failure alert |

This prevents surprise production crashes.

## IMPORTANT: REFER THIS FOR PRIOR DETECTION OF OOMKILL SETUP 
- [📌 Prior OOM Risk Detection in Kubernetes Using Memory Growth (A-B Timeshift) in SigNoz](/observability/priorOOMdetection.md)

---

# 🔎 How to Diagnose OOMKill Step-by-Step 

### Step 1: Check Events

```bash
kubectl get events --sort-by=.metadata.creationTimestamp
```

### Step 2: Check Pod Logs 

```bash
kubectl logs <pod> --previous
```

### Step 3: Check Resource Limits

```bash
kubectl describe pod <pod>
```

### Step 4: Monitor Memory Trend 

Look for:

* Spikes
* Gradual increase
* Memory saturation patterns

---

# ⚠️ Why OOMKill is Hard to Debug

Because:

* No stack trace (SIGKILL is forceful)
* Logs may disappear after restart
* Happens suddenly
* Looks like “random crash”

That’s why observability + metrics > logs alone.

---

# 🛡️ Prevention & Best Practices

## 1️⃣ Set Proper Memory Requests & Limits

Avoid:

```
Too Low Limits → Frequent OOMKills
Too High Limits → Resource wastage
```

---

## 2️⃣ Use Memory Profiling Tools

Examples:

* pprof (Go)
* heapdump (Node.js)
* JFR (Java)

---

## 3️⃣ Enable Early Alerts 

Instead of:

- Alert only when OOMKilled happens ❌

Use:

- Alert when memory crosses 70–80% ✔️

---

## 4️⃣ Autoscaling Based on Memory

Use:

* HPA (Horizontal Pod Autoscaler)
* VPA (Vertical Pod Autoscaler)

---

# 📌 Quick Debug Checklist 

When you see OOMKilled:

* Check Exit Code (137?)
* Inspect memory limits
* Analyze memory usage trend
* Look for memory leaks
* Check node memory pressure
* Review recent deployments
* Set early observability alerts
* Optimize application memory usage

---

# 📖 References

- [Signoz Guide](https://signoz.io/guides/what-is-oom/)
- [Signoz UserGuide](https://signoz.io/docs/userguide/query-builder-v5/)
- [Exit Code 137](https://spacelift.io/blog/oomkilled-exit-code-137)
- [Hidden Memory Leak](https://unixarena.com/2025/04/oomkilled-in-kubernetes-the-hidden-memory-leaks-youre-missing.html/)
- [understanding OOM kill](https://mihai-albert.com/2022/02/13/out-of-memory-oom-in-kubernetes-part-1-intro-and-topics-discussed/#table-of-contents)