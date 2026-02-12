# 📌 Case Study: Implementing OOMKilled Detection Alerting in Kubernetes Using SigNoz

Prepared by: Shrushti Shrivastav| Devops intern at Scitara| February 2026

---

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/casestudy/img/oom.webp" width="600">
</div>


## 1️⃣ Background

As part of **production observability improvements**, I was tasked with implementing proactive alerting for container failures in our Kubernetes cluster.

One recurring issue in Kubernetes environments is:

```
Container terminated with Reason: OOMKilled
Exit Code: 137
```

Even if the application appears healthy overall, OOMKilled events can silently cause:

* Pod restarts
* Traffic imbalance
* Latency spikes
* Service instability

The **goal of my task** was:

> Detect OOMKilled events immediately using SigNoz and trigger alerts before repeated restarts impact system stability.

---

# 2️⃣ Problem Statement

Before this alert existed:

* Pods were restarting occasionally.
* Engineers had to manually inspect logs.
* OOMKilled events were not immediately visible.
* There was no automated detection mechanism.

This created delayed incident response.

We needed a way to:

✔ Automatically detect OOMKilled
✔ Differentiate it from normal completion
✔ Avoid false alerts
✔ Alert only when necessary

---

# 3️⃣ Understanding the Metric

While exploring Kubernetes metrics in SigNoz, I identified:

```
k8s.container.status.last_terminated_reason
```

This metric provides the reason for the last container termination.

Common values observed:

| Value       | Meaning                         |
| ----------- | ------------------------------- |
| `OOMKilled` | Container exceeded memory limit |
| `Error`     | Application-level crash         |
| `Completed` | Container exited successfully   |

This metric became the foundation of the alert.

## About `k8s.container.status.last_terminated_reason`

This Kubernetes metric indicates the reason why a container last terminated. It is crucial for distinguishing between expected exits and failure scenarios.

Observed categories:

* `OOMKilled` → Container exceeded memory limit and was killed by the kernel
* `Error` → Application-level failure or crash
* `Completed` → Normal termination (common in batch jobs)

This metric enables targeted alerting and reduces false positives in monitoring systems.

---

# 4️⃣ Alert Design Strategy

Instead of alerting on every restart, I designed a more meaningful condition.

### Why?

* Some restarts are expected.
* Jobs complete normally.
* Deployments may temporarily restart pods.

So the alert needed to specifically target:

```
last_terminated_reason = OOMKilled
```

---

# 5️⃣ Implementation in SigNoz

### Step 1: Metric Selection

Selected:

```
k8s.container.status.last_terminated_reason
```

### Step 2: Filter Condition

Set condition:

```
= "OOMKilled"
```

### Step 3: Aggregation Strategy

Instead of alerting per single pod instantly, we:

* Aggregated by namespace or deployment
* Used time window (e.g., 5 minutes)
* Triggered alert only if condition sustained

This reduced alert noise.

---

# 6️⃣ Why This Alert Is Important

OOMKilled is different from other failures.

### Difference Between Termination Types

| Termination Type | Meaning             | Severity |
| ---------------- | ------------------- | -------- |
| Completed        | Normal exit         | Low      |
| Error            | App crash           | Medium   |
| OOMKilled        | Resource exhaustion | High     |

OOMKilled indicates:

* Memory limit misconfiguration
* Traffic spike
* Memory leak
* Incorrect resource sizing

It is a **resource management issue**, not just an application bug.

---

# 7️⃣ Technical Insight Gained

While implementing the alert, I deepened understanding of:

### 🔹 Exit Code 137

137 = 128 + 9 (SIGKILL)

Meaning:
Container was forcefully killed by Linux kernel.

### 🔹 Cgroups and Memory Limits

Kubernetes enforces container memory limits using Linux Cgroups.

Even if node has free memory:
If container crosses its defined limit → it gets killed.

### 🔹 Working Set vs Total Memory

Learned that:

* Kubernetes eviction decisions rely on working set memory.
* Monitoring total memory alone is insufficient.

---

# 8️⃣ Improvements Added

To make the alert more effective, we:

### ✅ Added Context Labels

Included:

* Namespace
* Pod name
* Container name

This made debugging faster.

### ✅ Avoided Alert Fatigue

Configured alert to trigger only if:

* OOMKilled detected
* Within defined time window

---

# 9️⃣ Business Impact

After implementing OOMKilled alert:

* Faster detection of memory issues
* Reduced manual log inspection
* Improved incident response time
* Better visibility into resource misconfiguration
* Improved reliability of Kubernetes workloads

It shifted monitoring from:

Reactive → Proactive

---

# 🔟 Lessons Learned

1. Not All Restarts Are Equal

2. Resource Limits Matter

3. Observability Is Layered

4. Alerts Should Be Meaningful

---

# 1️⃣1️⃣ Final Conclusion

This task enhanced my understanding of:

* Kubernetes resource management
* Linux memory behavior
* Container lifecycle
* Exit codes
* Observability best practices
* Designing low-noise, high-signal alerts

Implementing OOMKilled detection was not just creating an alert —
it required understanding how Kubernetes interacts with Linux memory management and how to convert system signals into actionable monitoring.

---
