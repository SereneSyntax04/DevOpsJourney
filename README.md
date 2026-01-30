# 🚀 DevOps Journey — From Foundations to Production

This repository documents my **end-to-end DevOps learning journey**, focused on **real-world practices**, not just theory.


Every section contains **structured notes + hands-on tasks** that reflect how tools are actually used in the industry.

---

## 🧠 What This Repo Represents

✔️ Practical DevOps mindset  
✔️ Tooling with intent (not tutorial hopping)  
✔️ Notes written for **revision + interviews**  
✔️ Hands-on tasks that simulate real workflows  

---

## 🐧 Linux for DevOps
Foundational Linux concepts required for cloud, containers, and automation.

📁 `linux/`
- 📘 [Linux Overview & Basics](/linkedin_linux/linux_basic.md)

---

## 🧱 Foundations of DevOps
Understanding *why* DevOps works before touching tools.

📁 `linkedin_foundation/`
- 📘 [DevOps Fundamentals](/linkedin_foundation/devops_foundation.md)
- 🔧 [Git Concepts & Commands](/linkedin_foundation/devops_foundation_Git.md)
- 🏗️ [Infrastructure as Code — Concepts](/linkedin_foundation/devops_foundation_IAC.md)

---

## 🛠️ Infrastructure as Code (Terraform)
Designing reproducible, auditable, and scalable infrastructure.

📁 `IAC/`
- 📘 [Terraform Core Concepts](/IAC/terraformTerms.md)
- 📘 [Detailed Terraform Theory](/IAC/DetailedTheoryTerraform.md)
- 🧪 [Hands-on Terraform Tasks](/IAC/Terraformtask/TaskReadme.md)
- 🖥️ [Local Terraform Practice](/IAC/localPractise/LocalSetupSteps.md)

---

## ☸️ Kubernetes
From architecture to application deployment and workloads.

📁 `k8s/`
- 📘 [Kubernetes Basics & Setup](/k8s/minikubeInstall.md)
- 🏛️ [Kubernetes Architecture](/k8s/architecture.md)
- 🔐 [Pods, Stateful Workloads & Security](/k8s/Managing.md)
- ⚙️ [Control Plane & Node Interaction](/k8s/nodesWork.md)
- 🚀 [Application Deployment Hands-on](/k8s/k8sappDeploy.md)
- 🧪 [Kubernetes Task](/k8s/k8sTask/taskReadme.md)

---

## 🔁 CI/CD & Automation
Building reliable pipelines and automation workflows.

📁 `cicd/`
- 📘 [CI/CD Concepts](/cicd/cicd_Theory.md)
- 🔧 [Jenkins Notes](/cicd/jenkins/jenkins.md)
- 🧪 [Jenkins Hands-on Task](/cicd/jenkins/jenkinsTask.md)
- 🔁 [Bitbucket Basics](/cicd/bitbucket.md)
- ⚙️ [Bitbucket Pipelines](/cicd/pipeline.md)

---

## 📊 Observability
Monitoring, metrics, and operational visibility.

📁 `observability/`
- 📘 [Observability Theory](/observability/observability.md)
- 📈 [Grafana Hands-on Task](/observability/DockerGrafanaTask/GrafanaTaskReadme.md)

---

## 📚 Case Studies & Compliance
Real-world decision-making and regulatory awareness.

📁 `casestudy/`
- 📄 [Choosing the Right Observability Tool](/casestudy/observability.md)
- 🏛️ [21 CFR Part 11](/casestudy/21cfrpart11.md)
- 🔐 [21 CFR Part 11 with SSO](/casestudy/cfrSSO.md)

---

## 🎯 Why This Repo Exists
I created this repository to:
- Build **strong DevOps fundamentals**
- Practice **production-oriented workflows**
- Maintain **revision-friendly notes**
- Prepare for **DevOps / Cloud interviews**

---

📌 *This repo will continue evolving as I deepen my DevOps experience.*










---
<br>



# 🧩 How to Clone This Repository Using VS Code

Follow these steps to clone this repository locally using **Visual Studio Code**.

---

### 🔹 Prerequisites
- Git installed
- Visual Studio Code installed
- GitHub account (optional but recommended)

---

### 🔹 Method 1: Clone Using VS Code UI

1. Open **Visual Studio Code**

2. Press:
```
Ctrl + Shift + P
```
to open the Command Palette

3. Type and select:
```
Git: Clone
```

4. Paste the repository URL:
```
[https://github.com/](https://github.com/)<your-username>/devops-journey.git
```

5. Select a local folder to clone the repository

6. Click **Open** when prompted

---

### 🔹 Method 2: Clone Using VS Code Terminal

1. Open **VS Code**
2. Open terminal:
```
Ctrl + `
```

3. Run the following command:
```bash
git clone https://github.com/<your-username>/devops-journey.git
```

4. Navigate into the repository:

   ```bash
   cd devops-journey
   ```
5. Open the project in VS Code:

   ```bash
   code .
   ```

---

### 🔹 Verify the Clone

After cloning, you should see folders like:

```
linux/
IAC/
k8s/
cicd/
observability/
casestudy/
```

You’re now ready to explore the repository 🚀
