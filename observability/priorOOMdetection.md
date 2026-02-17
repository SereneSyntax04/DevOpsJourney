# 📌 Prior OOM Risk Detection in Kubernetes Using Memory Growth (A-B Timeshift) in SigNoz

Prepared by: Shrushti Shrivastav| Devops intern at Scitara| February 2026

---

## 🧠 Objective
Create a **predictive alert** to detect potential OOMKilled events **before they happen** by monitoring:
- High memory utilization
- Increasing memory trend over time

This reduces reactive firefighting and enables early intervention.

---

## 🏗️ Alert Strategy 

Instead of only using a static threshold (`memory > 80%`), we use:

**High + Increasing Memory = Strong OOM Risk Signal**

Formula logic:

```
F1 = A - B
Where:
A = Current memory utilization
B = Memory utilization 5 minutes ago (timeshift)
```

Alert triggers when:

```
A > 80% AND (A - B) > 10%
```

Meaning:
- Pod is already under memory pressure (>80%)
- Memory is still increasing (growth trend i.e increment by 10%)

---

## 📊 Metrics Used
**Metric:**

```
k8s.container.memory_limit_utilization
```

This represents:<br>
Percentage of memory used relative to the container memory limit

Example:
- 0.50 = 50% memory used
- 0.75 = 75% memory used
- 0.95 = Critical zone (near OOMKill)

---

## 🔍 Query Configuration in SigNoz (Using A > 50% and A-B > 5% )

### Note: Ideal configuration must be
**A > 0.70 (70%)** <br>
**A-B > o.1 (10%)**

---

### Query A (Current Memory - Filtered)
- Metric: `k8s.container.memory_limit_utilization`
- Aggregation: `Max 60sec`
- Aggregation: `Avg`
- Group By:
  - `k8s.pod.name`
  - `k8s.namespace.name`
- HAVING:
```
avg(k8s.container.memory_limit_utilization) > 0.50
```
(this is used to focus on only those pods that have memory more than 50% (A>50%), remember this is just for trial purpose.)

- Filter: (used to avoid certain pod) **Optional**
```
k8s.namespace.name != 'ABC' AND k8s.namespace.name != 'XYZ'
```

📌 Purpose: <br>
Filters only pods already using significant memory and removes low-usage noise.

---

### Query B (Historical Baseline - 5 Minutes Ago)
- Same metric as Query A
- Same group by fields
- Time Shift: `300 seconds` (i.e 5 min)
- NO HAVING filter (important)

📌 Purpose:
Provides historical memory baseline for trend comparison.

---

## 🧮 Formula Logic
```
F1 = A - B
```

Interpretation:
- Positive value → Memory increasing
- Near 0 → Stable memory
- Negative → Memory decreasing

Example:
| A (Now) | B (5 min ago) | F1 (A-B) | Meaning |
|--------|---------------|----------|---------|
| 0.72 | 0.60 | 0.12 | Rapid increase (High OOM risk) |
| 0.68 | 0.66 | 0.02 | Stable memory |
| 0.55 | 0.40 | 0.15 | Possible memory leak pattern |

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/observability/assets/images/queryA.png"> <img src="/observability/assets/images/queryB.png">
</div>


---

## 🚨 Alert Condition Setup
- Evaluate Query: `F1`
- Threshold: `> 0.05`
- Run Alert Every: `1 minute`
- Minimum Data Points: `5`

This effectively creates a ~5 minute evaluation window.

```
| Minute | F1   |
| ------ | ---- |
| 1      | 0.07 |
| 2      | 0.12 |
| 3      | 0.09 |
| 4      | 0.08 |
| 5      | 0.06 |

(ensure it's 'all the time' cause this ensures, F1 must stay above threshold for the ENTIRE 5-minute window to trigger alert.)

```

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/observability/assets/images/window.png"> <img src="/observability/assets/images/alert.png">
</div>

---

## ⏱️ Understanding the 5-Minute Window 

### TimeShift (300s)
- Compares current memory vs memory 5 minutes ago
- Detects growth trend

### Minimum Data Points = 5
- Ensures sustained behavior
- Prevents alerts from short spikes

Together:<br>
**Alert triggers only if memory keeps increasing consistently, not due to temporary bursts.**

---

## 🎯 Why HAVING is Applied Only on Query A 

### Correct Setup:
- HAVING on A ✅
- No HAVING on B ✅

Reason:
If HAVING is applied on Query B, historical data may get filtered out, causing:
- NULL values in formula
- Incorrect spikes
- Missed alerts

Best Practice:<br>
Always keep baseline (B) unfiltered for accurate trend comparison.

---

## 🧪 What This Alert Will Detect
✔ Pods with sustained memory growth  
✔ Potential memory leaks  
✔ Pre-OOM pressure patterns  
✔ Gradual memory escalation before crash  

<div style="display:flex; justify-content:center; gap:10px;">
  <img src="/observability/assets/images/graph_memory.png"> <img src="/observability/assets/images/emailformemory.png">
</div>

---

### 🔎 Summary of Current Alert Setup (Pre-OOM Detection)

* Created a predictive alert using `k8s.container.memory_limit_utilization` where Query A filters pods with memory usage > 50% (A > 0.50) and Query B uses a 5-minute timeshift baseline (300s), with formula F1 = A - B to detect growth.
* Alert triggers when F1 > 0.05 (5% memory increase) **on average over the last 5 minutes**, helping identify pods under sustained and increasing memory pressure before a potential OOMKilled event while excluding system namespaces to reduce noise.
