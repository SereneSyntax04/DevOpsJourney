<h1 align="center">EKS V 1.35</h1>
Prepared by: Shrushti Shrivastav| Devops intern at Scitara| February 2026

## Kubernetes 1.35 Upgrade for EKS — Features, Breaking Changes, and Validation Checklist
Kubernetes releases introduce new capabilities, stronger security defaults, and improved resource management — but they also introduce behavioral changes that can silently break existing workloads if clusters are not prepared correctly.

This **case study** analyzes the upgrade path from **Amazon EKS Kubernetes v1.33 to v1.35**, focusing on both **new platform capabilities** and **operational risk areas** that must be reviewed before upgrading.

According to the official lifecycle schedule:
| Version  | Upstream Release | EKS Release  | Standard Support Ends | Extended Support Ends |
| -------- | ---------------- | ------------ | --------------------- | --------------------- |
| **1.35** | Dec 17, 2025     | Jan 27, 2026 | Mar 27, 2027          | Mar 27, 2028          |


With EKS 1.35 now released, teams running older supported versions such as 1.33 must begin upgrade readiness evaluation to avoid:

- Extended support billing
- Runtime incompatibilities
- Node configuration failures
- Security policy enforcement breaks
- Workload scheduling changes



---
<br>


## 🧭 Context: EKS Lifecycle Reminder

- 1.33 is in standard support until ~July 29 2026 on Amazon EKS; after that it enters extended support with additional cost. Upgrading before that date avoids charges and ensures you get normal patching.
- EKS supports only a rolling window of recent Kubernetes versions (1.35, 1.34, 1.33 currently) and drops older ones as they reach EOL.


---
<br><br><br>


# 1️⃣ Executive Context — Why This Upgrade Matters Now ?

Amazon EKS Kubernetes version **1.33** is under standard support until **~July 29, 2026**. After this date, clusters move into **extended support**, which introduces **additional cost** and slower patch coverage.

Upgrading late creates two risks:

* 💰 Higher operational cost (extended support fees)
* ⚠️ Higher failure risk due to accumulated behavior shifts
* 🧨 Silent failures caused by stricter defaults
* 🔒 Security hardening that exposes hidden misconfigurations

---
<br><br>

# 2️⃣ Current Baseline vs EKS 1.35 — What Actually Changes

- Most EKS v1.33 clusters run successfully because Kubernetes was more tolerant in runtime, security, and scheduling behavior.
- EKS v1.35 introduces **stricter defaults + new capabilities**, which means some previously tolerated setups will now fail.

This section shows **Before → After → What You Must Do**.


## 🖥️ Runtime & Node Layer — Permanent Platform Shifts

| Area              | EKS v1.33 Behavior        | EKS v1.35 Behavior          | Operator Impact                     |
| ----------------- | ------------------------- | --------------------------- | ----------------------------------- |
| cgroups           | cgroup v1 or v2 tolerated | **cgroup v2 expected**      | Must use AL2023 or Bottlerocket     |
| Container Runtime | containerd v1.x works     | **containerd v2+ expected** | Validate runtime version            |
| Node OS           | Amazon Linux 2 common     | AL2023 preferred            | Upgrade node AMI                    |
| kubelet behavior  | forgiving startup checks  | stricter validation         | Node join failures if misconfigured |


## 📦 Container Runtime & Image Pull Behavior

| Area              | v1.33                    | v1.35                    | Operator Focus         |
| ----------------- | ------------------------ | ------------------------ | ---------------------- |
| Image pulls       | cache often hides issues | strict credential checks | test cold pulls        |
| Image secrets     | loosely validated        | strictly validated       | rotate secrets         |
| container sandbox | tolerant lifecycle       | stricter lifecycle       | restart testing needed |


### ⚠️ Practical Change

```diagram
Pod Starts
   │
   ▼
Image Pull Attempt
   │
   ├── Secret valid → ✅ Pull succeeds
   │
   └── Secret invalid → ❌ ImagePullBackOff
                         (cached images no longer hide issue)
```

**Previously:**

Pod restarts worked because image already cached

**Now:**

Restart may fail **if credentials are wrong**



## 🔐 Access & Debug Protocol Changes

| Area            | v1.33                          | v1.35                   | Operator Focus      |
| --------------- | ------------------------------ | ----------------------- | ------------------- |
| exec/log/attach | SPDY protocol                  | **WebSockets**          | proxy + RBAC checks |
| RBAC            | loose permissions often worked | strict subresource RBAC | update roles        |
| debug access    | implicit                       | explicit                | validate access     |


```diagram
kubectl exec/log
      │
      ▼

1.33 Flow
──────────
Client → SPDY → kubelet → Pod


1.35 Flow
──────────
Client → WebSocket → RBAC subresource check → kubelet → Pod
                              │
                              └── missing permission → DENIED
```


### Required RBAC Now

```yaml
resources:
- pods
- pods/log
- pods/exec
- pods/attach
- pods/portforward
verbs:
- get
- list
- create
```

## 📈 Pod Resource Management — Feature Becomes Active

| Area          | v1.33          | v1.35                | Operator Focus               |
| ------------- | -------------- | -------------------- | ---------------------------- |
| Pod resize    | beta           | **GA + active**      | apps must handle live resize |
| Memory shrink | restart-based  | live possible        | OOM risk                     |
| VPA           | restart resize | live resize possible | update VPA mode              |

```diagram
Before (Beta Resize)
────────────────────
Resize request
     │
     ▼
Pod restarted
     │
     ▼
New resources applied


Now (GA In-Place Resize)
────────────────────────
Resize request
     │
     ▼
Live resource change
     │
     ├── App handles it → ✅ OK
     └── App assumes restart → 💥 OOM / crash
```


### ⚠️ New Risk Introduced

Apps that assume restart on memory change may crash instantly.

Common risk apps:

* Java
* Node.js
* Python memory-heavy apps


## 🧠 Scheduler Behavior — From Simple → Constraint-Aware

| Area          | v1.33          | v1.35                  | Operator Focus          |
| ------------- | -------------- | ---------------------- | ----------------------- |
| Scheduling    | capacity-based | rule-based             | more Pending pods       |
| Tolerations   | simple strings | numeric & weighted     | audit tolerations       |
| Placement     | basic          | workload-aware (alpha) | validate affinity       |
| Node features | implicit       | declared               | label accuracy required |


### Practical Impact

Previously:

> Pod scheduled if resources available

Now:

> Pod may remain Pending due to rule mismatch

Must validate:

* taints
* tolerations
* nodeSelector
* affinity
* resource requests

```diagram
Pod arrives
   │
   ▼
Check requests fit?
   │
   ├── No → Pending
   │
   └── Yes
        │
        ▼
Check taints/tolerations
        │
        ├── No match → Pending
        │
        ▼
Check affinity / labels
        │
        ├── No match → Pending
        │
        ▼
Schedule pod
```


---

## 📊 Before vs After Summary Grid

Area        | v1.33        | v1.35
-------------|--------------|-------------
cgroup       | v1 allowed   | v2 required
runtime      | containerd1  | containerd2+
exec proto   | SPDY         | WebSockets
resize       | beta         | GA live
scheduler    | simple       | rule-based
RBAC         | loose        | strict


---
<br><br>


# 3️⃣ New Capabilities Introduced in EKS 1.35 (New Benefits/Feature Gains)

EKS 1.35 introduces several platform and operational improvements that make workload management more flexible and predictable.

## 🚀 Platform Capabilities

* **In-place Pod Resize (GA)** — CPU and memory can be adjusted without restarting pods
* **Workload-aware scheduling (alpha)** — scheduler can consider workload type and behavior
* **Node declared features** — nodes can advertise capabilities for smarter placement
* **Smarter placement controls** — better affinity and constraint handling

## 🔐 Security Improvements

* Stronger identity and access boundaries
* Stricter credential validation for pulls and API access
* Modernized API connection protocol (WebSockets)

## ⚙️ Operational Gains

* Better vertical scaling support
* Fewer restart-driven resource changes
* More predictable scheduling outcomes


---
<br><br>

# 4️⃣ Add-on & Dependency Compatibility Review

Control plane upgrade ≠ add-on readiness

Check:

* VPC CNI
* CoreDNS
* kube-proxy
* CSI
* Autoscaler
* Mesh
* Admission controllers

---
<br><br>


# 5️⃣ Pre-Upgrade Validation Checklist ✅

## Node Layer

* ☐ OS = AL2023 / Bottlerocket
* ☐ cgroup v2 confirmed
* ☐ containerd v2+

---

## Access Layer

* ☐ exec/log works
* ☐ RBAC verified
* ☐ CI pipelines tested

---

## Workload Layer

* ☐ Pod restart tests
* ☐ Image pull tests
* ☐ Secret rotation tested

---

## Scheduling Layer

* ☐ Taints reviewed
* ☐ Tolerations defined
* ☐ Requests realistic

---

## Security Layer

* ☐ ServiceAccounts reviewed
* ☐ IRSA annotated
* ☐ Admission policies checked

---

# 6️⃣ Upgrade Execution Strategy — EKS Specific

## Correct Order

```
Control Plane
   ↓
Managed Add-ons
   ↓
Node Groups
   ↓
Workload Rollout Tests
```

---

## Safer Deployment Pattern

* Blue/green node groups
* Canary workloads
* Rolling node replacement
* Rollback node group ready

---

# 7️⃣ Risk Matrix

| Area      | Risk       | Symptom          | Detection    | Mitigation   |
| --------- | ---------- | ---------------- | ------------ | ------------ |
| cgroup    | Node fails | NotReady         | kubelet logs | Use AL2023   |
| RBAC      | exec fails | Forbidden        | auth can-i   | Update roles |
| Runtime   | pull fails | ImagePullBackOff | pod events   | Fix secrets  |
| Resize    | OOM        | OOMKilled        | describe pod | Fix limits   |
| Scheduler | Pending    | Unschedulable    | describe pod | Fix requests |

---

# 8️⃣ Post-Upgrade Verification Plan

## Cluster Health

```bash
kubectl get nodes
kubectl get pods -A
```

---

## Functional Tests

* exec/log access
* pod restart behavior
* scaling events
* autoscaler reaction
* metrics pipeline

---

## OOM Detection

```bash
kubectl get events --field-selector reason=OOMKilled
```

---

# 9️⃣ Conclusion 

Kubernetes version upgrades now introduce:

* default security hardening
* stricter runtime behavior
* smarter scheduling logic
* protocol modernization

These changes improve platform safety — but expose hidden assumptions.

---

Nice — for a case study, references should not be raw URLs only. They should be **titled, categorized, and credible**. That makes your report look researched and professional.

Here’s a clean **Markdown-ready References section** with:

* proper titles
* grouped by topic
* your links fixed
* additional high-quality official sources added
* no tracking params

You can paste directly.

---

# 📚 References


* **Amazon EKS Kubernetes Version Support Policy**
  [https://docs.aws.amazon.com/eks/latest/userguide/kubernetes-versions.html](https://docs.aws.amazon.com/eks/latest/userguide/kubernetes-versions.html)

* **Amazon EKS User Guide — Cluster Upgrades**
  [https://docs.aws.amazon.com/eks/latest/userguide/update-cluster.html](https://docs.aws.amazon.com/eks/latest/userguide/update-cluster.html)

* **Amazon EKS Add-ons Compatibility**
  [https://docs.aws.amazon.com/eks/latest/userguide/eks-add-ons.html](https://docs.aws.amazon.com/eks/latest/userguide/eks-add-ons.html)

* **Kubernetes v1.35 Release Blog / Sneak Peek**
  [https://kubernetes.io/blog/2025/11/26/kubernetes-v1-35-sneak-peek/](https://kubernetes.io/blog/2025/11/26/kubernetes-v1-35-sneak-peek/)

* **Kubernetes Release Notes (All Versions)**
  [https://kubernetes.io/releases/](https://kubernetes.io/releases/)

* **Kubernetes Feature Gates Reference**
  [https://kubernetes.io/docs/reference/command-line-tools-reference/feature-gates/](https://kubernetes.io/docs/reference/command-line-tools-reference/feature-gates/)

* **Kubernetes and cgroup v2 Support**
  [https://kubernetes.io/docs/concepts/architecture/cgroups/](https://kubernetes.io/docs/concepts/architecture/cgroups/)

* **containerd Runtime Documentation**
  [https://containerd.io/docs/](https://containerd.io/docs/)

* **Bottlerocket OS for Kubernetes Nodes**
  [https://bottlerocket.dev/](https://bottlerocket.dev/)

* **Kubernetes RBAC Authorization**
  [https://kubernetes.io/docs/reference/access-authn-authz/rbac/](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)

* **kubectl exec / attach / port-forward behavior**
  [https://kubernetes.io/docs/tasks/debug/debug-application/get-shell-running-container/](https://kubernetes.io/docs/tasks/debug/debug-application/get-shell-running-container/)

* **Kubernetes API Streaming Protocol Updates (SPDY → WebSockets)**
  [https://kubernetes.io/docs/reference/using-api/api-concepts/](https://kubernetes.io/docs/reference/using-api/api-concepts/)

* **In-Place Pod Resource Resize**
  [https://kubernetes.io/docs/tasks/configure-pod-container/resize-container-resources/](https://kubernetes.io/docs/tasks/configure-pod-container/resize-container-resources/)

* **Vertical Pod Autoscaler (VPA)**
  [https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler)

* **Kubernetes Scheduling Concepts**
  [https://kubernetes.io/docs/concepts/scheduling-eviction/](https://kubernetes.io/docs/concepts/scheduling-eviction/)

* **Taints and Tolerations**
  [https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/)

* **Node Affinity & Selectors**
  [https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/)

* **IAM Roles for Service Accounts (IRSA)**
  [https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html)

* **EKS Pod Identity & Service Accounts**
  [https://docs.aws.amazon.com/eks/latest/userguide/service-accounts.html](https://docs.aws.amazon.com/eks/latest/userguide/service-accounts.html)

---
