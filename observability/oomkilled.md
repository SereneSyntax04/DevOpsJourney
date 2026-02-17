# 📌 Implementing OOMKilled Detection Alerting in Kubernetes Using SigNoz

Prepared by: Shrushti Shrivastav| Devops intern at Scitara| February 2026

---

## Problem Statement

During Kubernetes workload monitoring, we observed intermittent pod restarts without clear application errors.  
After investigation, the root cause was identified as **OOMKilled (Out Of Memory Kills)**.

These events were not being proactively detected, which delayed debugging and increased downtime risk.

Goal:  <br>
**Build a reliable alerting mechanism in SigNoz to detect OOMKilled events immediately.**

---

## 📖 What is OOMKilled in Kubernetes?

OOMKilled occurs when a container exceeds its memory limit and the Linux OOM (Out Of Memory) Killer forcibly terminates it.

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/observability/assets/images/oom.webp">
</div>

Key behavior:
- Container memory crosses limit
- Kernel OOM Killer terminates process
- Pod restarts automatically
- Exit Code: **137**

This makes it tricky because:
- Application logs may not show explicit errors
- Pods appear “healthy” after restart
- Memory leaks remain hidden

### UNDERSTANDING OOMKILL
[Detailed explanation on OOMKILL](/casestudy/code137_oomkilled.md)
---

## 🧪 Real Scenario 

Imagine a backend service running smoothly in a Kubernetes cluster.  
Traffic increases gradually, but memory usage keeps growing due to a hidden leak.

What happens next?
1. Memory limit is reached  
2. Kubernetes triggers OOM Killer  
3. Pod gets terminated (OOMKilled)  
4. Pod restarts automatically  
5. Issue goes unnoticed without proper alerting  

**This creates a silent failure loop.**

---

## 🛠️ Why SigNoz for OOMKilled Detection?

SigNoz provides:
- Metrics + Logs correlation
- Kubernetes observability
- Custom PromQL-based alerts
- Real-time monitoring dashboards

Instead of manually checking pod status, automated alerting ensures faster detection.

---
<br>

# ⚙️ Alert Logic in SigNoz v0.105.1 (Beta)

We are using **SigNoz v0.105.1 (Beta)** for this alert implementation. <br>
**(You can try a similar setup with Classic alerts as well.)**

### 📈 Metrics Used

Primary Kubernetes metric:
- `kube_pod_container_status_last_terminated_reason`
- Filter: `reason="OOMKilled"`

This metric helps track the last termination reason of containers. which makes alert specific for 'oomkilled'

### The newer (beta) version introduces enhanced capabilities such as:
- Formula-based alert evaluation
- Functions (like Time Shift)
- Flexible query comparison
- Better control over noise reduction

Unlike the classic alerting system, the beta alert engine allows us to use **Query Builder + Functions + Formula**, which makes it possible to detect only *new OOMKilled events* instead of historical ones.

---

## 🔎 Query Options Available in SigNoz

SigNoz provides two ways to create alert queries:

1. **Query Builder (UI-based)** – Recommended for structured metric logic  
2. **PromQL (Advanced)** – Direct metric query writing  

For this case study, we used: <br>
**✅ Query Builder (with Formula & Time Shift)**

Reason:
- Easier comparison between current vs past values  
- Cleaner logic for delta-based alerting  
- Native support in v0.105.1 beta  

---

## 🧮 Detection Strategy (Only New OOMKills)

The main goal was: <br>
**Detect only *new OOMKilled events* and ignore past/stale data.**

Instead of triggering alerts on total restart count, we compare:
- Current value (A)
- Past value using Time Shift (B)

This prevents repeated alerts for the same historical OOMKills.

---

## ⏱️ Time Shift Logic

We applied the **Time Shift function** on Query B to fetch past metric values from a previous time bucket.

Concept:
- Query A → Current restart/OOMKilled value
- Query B → Same metric, but shifted to past time

This creates a real-time comparison model:

```
Current vs Previous Bucket
```

### Why Time Shift is Important ?

**Without** Time Shift:
- Alert keeps firing on old OOMKills
- High alert noise
- No distinction between old and new incidents

**With** Time Shift:
- Only fresh increases are detected
- Historical data is ignored
- More accurate incident alerting

---

## 📐 Formula Used to Get the Result

We used the formula:
```
A - B
```

Where:
- **A = Current value**
- **B = Past value (Time Shift applied)**

### How It Works ??

If restart count increases inside that 1-minute window:

Minute 1:
- A = 14  
- B = 13  
- A - B = 1 → 🚨 Alert Triggered (New OOMKill)

Next Minute:
- A = 14  
- B = 14  
- A - B = 0 → ✅ No Alert (No new kill)

This ensures:
- Alerts only on *new* OOMKilled events  
- No repeated alerts for the same crash  
- Noise-free monitoring  

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/observability/assets/images/A.png"> <img src="/observability/assets/images/B_F1.png"> <br> <img src="/observability/assets/images/alert_condition.png"> <img src="/observability/assets/images/notification.png">
</div>

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/observability/assets/images/graph.png"> <img src="/observability/assets/images/email.png">
</div>

### Required Changes:
- aggrigate with time series : **latest** every : **60** seconds (both queries)
while implementing this setup ensure time range is 60 and not 8000 (kept 8000 for trial purpose)
- timeshift (query B) must be **60** 
- To receive alert notifications, please configure your email address. In the screenshot I shared, the email field is highlighted in blue (I’ve hidden the actual email for privacy).
- **NOTE** IN IMAGE ABOVE, notification shows: (current value:15) i.e previously 14 oomkill were detected but that data is collection of probably 6 month and when new oomkill was detected number increased to 15 and we got alert only for new oomkill and not historical data

---

## 🪣 (IMPORTANT) Critical Configuration: TimeShift Must Equal Bucket Size 

This is the most crucial part of the setup.

In SigNoz Query Builder:

If:

```
Aggregate within = Latest every 300s
```

Then each data point represents a **5-minute bucket**.

So if the requirement is:<br>
**“Compare current bucket with previous bucket”**

Then:
```
TimeShift = 300 seconds
```

### Why?
Because:
- A = Current 5-minute bucket value
- B = Previous 5-minute bucket value (shifted by 300s)

If TimeShift ≠ Bucket Size:
- Query returns No Data
- Incorrect comparisons
- Alert misfires or fails

---

## 🧠 Final Alert Evaluation Logic

1. Collect latest metric value (A)
2. Fetch past metric using Time Shift (B)
3. Apply formula: `A - B`
4. Trigger alert only when result > 0

This guarantees:
- Detection of only fresh OOMKilled events  
- No false alerts from historical crashes  
- Stable and production-friendly alerting  

---

## 🧪 Why Beta Alert Engine (v0.105.1)?

This setup is implemented on:<br>
**SigNoz v0.105.1 Beta**

Because:
- Beta supports **Formula + Functions (Time Shift)**
- Classic alerts do NOT support advanced delta comparison
- Required for bucket-to-bucket evaluation logic

Hence, beta alerting was necessary to build a precise  
“New OOMKill Detection” system instead of a generic restart alert.

---
<br>
