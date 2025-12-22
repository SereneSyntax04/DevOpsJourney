<h1 align='center'>Devops Foundation: <br> CI/CD</h1>

<p align="center">
  <img src="./assets/images/cicdTool.webp" alt="DevOps Infinity Loop" width="650"/>
</p>

---
<br><br>

<h1 align="center">☁️⚙️ Chapter 1. Continuous Integration and Continuous Delivery 🏗️☁️</h1>
<br>

## 📌 Why CI/CD Exists (The Problem It Solves)

Most organizations struggle with:
- Painful, stressful release days 😰
- Buggy and unstable deployments
- Long release cycles (weeks or months)
- Fear of touching production code

**CI/CD exists to kill this chaos.**  
It replaces fear with automation, predictability, and speed.

<p align="center">
  <img src="./assets/images/cicd-pipeline.png" alt="CI/CD Pipeline Diagram" width="700"/>
</p>

<br>

## 🧠 Core CI/CD Concepts (At a Glance)

| Term | Meaning | Goal |
|-----|-------|------|
| **Continuous Integration (CI)** | Automatically build & test code on every commit | Catch bugs early |
| **Continuous Delivery (CD)** | Automatically deploy to production-like environments | Always be release-ready |
| **Continuous Deployment** | Automatically deploy to production | Zero manual gates |

<br><br>

<h1 align='center'> 📘 Glossary of CI/CD Terms </h1>

| Term | Definition |
|----|-----------|
| **Continuous Integration (CI)** | Automatically and frequently building and unit testing the entire application, ideally on every code commit |
| **Continuous Delivery (CD)** | Automatically deploying every successful build to a production-like environment and validating it with automated tests |
| **Continuous Deployment** | Automatically deploying every build to production after it passes all automated tests |
| **Integration Testing** | Tests performed as multiple application components are combined and validated together |
| **End-to-End (E2E) Testing** | Tests that validate the complete user flow of an application, simulating real user behavior |
| **Security Testing** | Tests designed to detect vulnerabilities in code and runtime to prevent breaches and data leaks |
| **Shift Left** | Moving testing, security, and validation as early as possible in the development lifecycle |


---
<br><br>


## 🔁 Continuous Integration (CI)

### 📖 Definition
Continuous Integration is the practice of **frequently merging code** into a shared repository and **automatically building and unit testing** it.

### 🧩 Key Characteristics

| Aspect | CI Practice |
|-----|------------|
| Code commits | Frequent, small changes |
| Branching | Short-lived branches |
| Testing | Automated unit tests |
| Feedback | Fast (minutes, not days) |

### 💡 Important Reality
- Developers should **build & test locally** before pushing
- Long-running branches = merge hell 🔥
- CI shortens the feedback loop for *every change*

<br>

## 🚚 Continuous Delivery (CD)

### 📖 Definition
Continuous Delivery extends CI by **deploying every successful build to a production-like environment** and running **automated integration & acceptance tests**.

### 🧩 What Gets Added in CD

| CI | ➕ | CD |
|---|---|---|
| Build | → | Deploy |
| Unit tests | → | Integration tests |
| Local validation | → | Production-like validation |

### 🧪 Environments Used
- Docker containers
- Virtual machines
- Mock services
- Staging / QA environments

👉 **Key rule:**  
Testing should *end* with a deployment.

<br>

## 🚀 Continuous Deployment (Next Level)

### 📖 Definition
Every change that passes **all automated tests** is **automatically deployed to production**.

### 😱 Sounds Scary?
Yes.  
But companies like:
- Facebook
- Etsy
- Wealthfront

do this **daily at massive scale**.

### 🔐 Why It Works
- Small changes
- Strong test coverage
- No manual bottlenecks

<br><br>

## ⚖️ CI vs CD vs Continuous Deployment

| Feature | CI | CD | Continuous Deployment |
|-----|----|----|----------------|
| Automated builds | ✅ | ✅ | ✅ |
| Automated tests | Unit | Unit + Integration | Full test suite |
| Auto deploy | ❌ | To staging | To production |
| Manual approval | Yes | Optional | ❌ |

<p align="center">
  <img src="./assets/images/ci-vs-cd-vs-deployment.png" alt="CI vs CD vs Continuous Deployment" width="650"/>
</p>

<br><br>

# 🌟 Benefits of Continuous Delivery

## 🧠 1. Empowered Teams (Cultural Shift)

| Before CD | After CD |
|---------|----------|
| Manual handoffs | Self-service pipelines |
| Blame between teams | Shared ownership |
| Reactive firefighting | Predictable workflow |

👉 Teams trust the pipeline, not heroics.

<br>

## ⏱️ 2. Drastically Reduced Cycle Time

| Organization Type | Release Time |
|------------------|-------------|
| Low performers | 1 week – 1 month |
| CD teams | Minutes – Hours |

<br>

## 🔐 3. Better Security (Yes, Faster = Safer)

| Metric | High Performers |
|------|----------------|
| Security remediation time | ⬇️ 50% |
| Compliance audits | Easier & repeatable |

Security becomes **continuous**, not last-minute panic.

<br>

## 😌 4. Stress-Free Releases

| Traditional Releases | CD Releases |
|---------------------|-------------|
| Big meetings | Normal workflow |
| Untested steps | Practiced every commit |
| High stress | Just another Tuesday |

👉 You’re *always practicing deployment*.

<br>

## 💰 5. More Business Value

| Impact | Result |
|-----|------|
| Less rework | More feature development |
| Fewer integration issues | Faster innovation |
| Time saved | ~29% more features |

Managers love it. Developers love it. Users love it.

<br><br>

<h1 align='center'> 🧱 CI/CD Pipeline (High Level)</h1>

A **build pipeline** is the complete sequence of automated steps that take code from a repository to a **running service in production**.  

How stages flow and provide feedback matters **more than the tools themselves**.

```
Code → Build → Test → Package → Store → Deploy → Test → Release
(Big Picture (Your Diagram, Simplified))
```
<br>

## 🧠 Core Pipeline Rules

```
Everything is code : application, infrastructure, deployment
Same artifact everywhere : build once, deploy many times
Same deploy process for test & prod : no “special” production steps
```

<br>
---

<p align="center">
  <img src="./assets/images/pipeline.png" alt="CI/CD Pipeline Diagram" width="700"/>
</p>

<br>

### 🔗 Pipeline Stages Breakdown

| Stage | What Happens | Tools (Examples) | Key Purpose |
|----|-------------|------------------|-------------|
| **Source Control** | Store all code: app, tests, deploy scripts, infra | Git, GitHub, GitLab, Bitbucket | Versioning & collaboration |
| **Build Trigger** | Detect code change and start pipeline | Jenkins, GitHub Actions, GitLab CI, CircleCI | Automation |
| **Build / Compile** | Compile or prepare application | Maven, Gradle, Make, Go compiler | Runnable code |
| **Unit Testing** | Run isolated tests (no external systems) | JUnit, PyTest, Jest | Early bug detection |
| **Package Artifact** | Bundle code into deployable unit | JAR/WAR, RPM, Docker Image | Consistency |
| **Artifact Repository** | Store versioned artifacts | Nexus, Artifactory, S3, Docker Registry | Reusability |
| **Deploy (Test Env)** | Automated deployment to test/CI env | Helm, Ansible, Terraform | Deployment validation |
| **Integration Testing** | Test real running service | API / REST tests | System correctness |
| **Acceptance Testing** | End-to-end validation | Selenium, Cypress, Manual (initially) | Business validation |
| **Deploy (Production)** | Same artifact, same deploy tool | Same as test deploy | Safe release |

---
<br>

## 🧪 Testing Strategy in the Pipeline

| Test Type | When It Runs | Purpose |
|--------|------------|--------|
| Unit Tests | During build | Validate logic |
| Integration Tests | After test deployment | Validate service |
| Acceptance Tests | Pre-prod / prod | Validate behavior |

Manual testing decreases as pipeline maturity increases.


---
---
<br><br>

<h1 align='center'>Detailed flow</h1>
refer above CI/CD Pipeline Diagram.

**CI/CD** is an automated process that moves code from a developer’s machine to production **safely and repeatedly**.


---

## 1. Source Code

### What it is
- Application code (Java, Python, Node.js, Go, etc.)
- Infrastructure code (Terraform, Kubernetes YAML)
- Test cases

### Tools
- VS Code
- IntelliJ
- Vim

--- 
<br>

## 2. Version Control System (VCS)

### What it does
- Stores code history
- Enables collaboration
- Triggers CI pipelines on every push

### Tools
- Git
- GitHub
- GitLab
- Bitbucket

### Flow
git commit → git push → CI pipeline triggers

---
<br>

## 3. Build System (CI Tool)

### What it is
The **orchestrator** of the entire pipeline.

### Responsibilities
- Pull code from Git
- Run build steps
- Execute tests
- Publish artifacts
- Trigger deployments

### Tools
- Jenkins
- GitHub Actions
- GitLab CI
- Azure DevOps

---
<br>

## 4. Build Tool

### What it does
Converts source code into a **runnable package**.

### Common Build Tools

| Language | Build Tool |
|--------|-----------|
| Java | Maven, Gradle |
| Node.js | npm, yarn |
| Python | pip, poetry |
| Go | go build |
| Containers | docker build |

### Output
- `.jar`
- `.war`
- Docker image
- Binary

This output is called an **Artifact**.

---

## 5. Unit Tests

### What they test
- Individual functions
- Methods
- Classes

### Tools
- JUnit
- pytest
- Jest
- Mocha

### Rule
If unit tests fail → **pipeline stops immediately**

---

## 6. Integration Tests (Early Stage)

### What they test
- App + Database
- API + Service
- Multiple internal components

### Purpose
Catch broken dependencies early in the pipeline.

---

## 7. Artifacts

### What is an Artifact?
A **versioned and immutable build output**.

### Examples
- `app-1.2.3.jar`
- `myapp:1.2.3` (Docker image)

### Rule
> The **same artifact** must be deployed to every environment.

---

## 8. Artifact Repository

### What it does
Stores build artifacts centrally.

### Tools
- Nexus
- JFrog Artifactory
- AWS ECR
- GitHub Packages

### Why it matters
- Enables rollbacks
- Improves traceability
- Ensures reproducibility

---

## 9. Deployment Server

### What it does
- Controls deployment flow
- Pulls artifacts from repository
- Triggers deployment tools

### Tools
- Jenkins
- ArgoCD
- Spinnaker

---

## 10. Deployment Tool

### What it does
Deploys artifacts into environments.

### Tools by Category

| Environment Type | Tool |
|-----------------|------|
| Virtual Machines | Ansible |
| Containers | Kubernetes |
| Cloud Infrastructure | Terraform |
| App Packaging | Helm |

---

## 11. CI Environment (Non-Production)

### What it is
A safe environment for validation.

### Common Names
- Dev
- QA
- Staging

### Purpose
Validate deployments before production.

---

## 12. Integration Tests (Late Stage)

### What they test
- End-to-end system interactions
- Multiple services working together

### Example
API → Database → Cache → Notification Service


---

## 13. End-to-End (E2E) Tests

### What they test
Real user workflows:
- Login
- Create order
- Payment
- Logout

### Tools
- Selenium
- Cypress
- Playwright

These are slower but critical.

---

## 14. Production Environment

### Final destination

If all tests pass:
- Same artifact
- Same deployment method
- Only configuration changes (secrets, URLs)

---

## Continuous Delivery vs Continuous Deployment

### Continuous Delivery
- Code is always deployable
- Manual approval before production

### Continuous Deployment
- Every successful build is deployed automatically

---
---


<br><br>

[Click here to redirect to INDEX](../README.md) 