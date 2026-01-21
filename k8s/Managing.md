# Managing Pods, Stateful Workloads, and Kubernetes Security

This document explains **how pods are managed**, **how stateful workloads are handled**, and **how Kubernetes security is applied**, based directly on real Kubernetes behavior and best practices.

---

## 1. Ways to Manage Kubernetes Pods

Kubernetes rarely runs **standalone pods** in production. Instead, it uses **controllers** to manage groups of pods.

---

### 1️⃣ Deployment (Most Common)

**What it is:**

* A Deployment manages **stateless applications**
* Ensures a desired number of pod replicas are always running

**What Deployments give you:**

* Scaling (up/down replicas)
* Rolling updates
* Rollbacks
* Self-healing

**How updates work (zero downtime):**

1. Old pods keep running
2. New version pods start
3. Kubernetes checks health
4. Old pods are terminated

**Used for:**

* Web apps
* APIs
* Microservices

---

### 2️⃣ DaemonSet

**What it is:**

* Ensures **exactly one pod per node**
* You do NOT control replica count

**Key behavior:**

* New node added → pod automatically scheduled
* Node removed → pod removed

**Used for background agents:**

* Log collection (Fluentd)
* Monitoring (Node Exporter)
* Security agents

**Important:**

> DaemonSets run infrastructure-level workloads, not applications

---

### 3️⃣ Job

**What it is:**

* Runs a task **until completion**
* Pod exits after success

**Key behavior:**

* Retries on failure
* Can run one or multiple pods

**Used for:**

* Batch processing
* Data generation
* Database migrations

---

### 4️⃣ CronJob

**What it is:**

* Scheduled Jobs (like Linux cron)

**Used for:**

* Backups
* Cleanup tasks
* Scheduled reports

---

## 2. Running Stateful Workloads in Kubernetes

Stateful applications **store data** and expect it to persist.

---

### Option 1: External Database (Most Common in Production)

**How it works:**

* Application runs in Kubernetes
* Database runs **outside the cluster**

**Examples:**

* Amazon RDS
* Google Cloud SQL
* Azure SQL

**Why this is preferred:**

* Easier backups
* Independent scaling
* Less operational complexity

---

### Option 2: Persistent Volumes (Inside the Cluster)

**Persistent Volume (PV):**

* Actual storage resource

**Persistent Volume Claim (PVC):**

* Storage request by a pod

**Key feature:**

* Data survives pod deletion

---

### StatefulSet (For Stateful Pods)

**What it is:**

* Controller for stateful applications

**What it guarantees:**

* Stable pod names (app-0, app-1)
* Stable network identity
* Stable storage via PVCs

**Used for:**

* Databases
* Kafka
* Elasticsearch

---

## 3. Kubernetes Security (Practical & Real)

Kubernetes clusters are **high-value targets**.

Attackers typically want to:

1. Steal data
2. Use compute power (crypto mining)
3. Launch DDoS attacks

---

## 3.1 Pod-Level Security (Security Context)

### Run containers as non-root

**Why:**

* Prevent attackers from installing software inside containers

**How:**

```yaml
securityContext:
  runAsNonRoot: true
  allowPrivilegeEscalation: false
```

---

### Read-only root filesystem

**Why:**

* Prevents modifying container filesystem

**How:**

```yaml
securityContext:
  readOnlyRootFilesystem: true
```

---

### Drop Linux capabilities

**Why:**

* Containers should run with minimum privileges

```yaml
securityContext:
  capabilities:
    drop:
      - ALL
```

---

## 3.2 Scan Kubernetes Manifests

### Infrastructure as Code (IaC) Scanning

**Tool example:** Snyk

**What it checks:**

* Security misconfigurations
* Privilege escalation risks
* Writable file systems

**Example command:**

#### Step 1: Install Snyk CLI
On Linux / macOS
```bash
curl -sL https://static.snyk.io/cli/latest/snyk-linux | sudo mv snyk-linux /usr/local/bin/snyk
chmod +x /usr/local/bin/snyk
```

#### Step 2: Verify installation
```bash
snyk --version
```

#### Step 3: Authenticate Snyk (This step is mandatory) and Run the command 
```bash
snyk auth
snyk iac test deployment.yaml
```

---

## 3.3 Keep Kubernetes Updated

**Why:**

* Security vulnerabilities (CVEs) are discovered regularly

**Best practice:**

* Apply security patches quickly
* Monitor Kubernetes CVE releases

---
