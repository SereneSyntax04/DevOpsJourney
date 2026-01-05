# Introduction to CI/CD and Bitbucket Pipelines

Modern software development demands speed, reliability, and collaboration.  
This is where **CI/CD** and tools like **Bitbucket Pipelines** come into play.

---

## What is CI/CD?

**CI/CD** stands for:

- **Continuous Integration (CI)**
- **Continuous Delivery (CD)**
- **Continuous Deployment (CD)**

These are the three core phases of modern software development pipelines.

- [Refer devops_foundation_cicd for detailed explanation](/linkedin_foundation/devops_foundation_cicd.md)

---

## Continuous Integration (CI)

Continuous Integration focuses on **frequent code integration**.

**How it works:**
- Developers write code locally.
- Changes are committed regularly to a shared repository.
- New code is merged with existing code.
- Automated checks run during integration.

**Typical CI checks include:**
- Code linting (syntax and style checks)
- Unit testing
- Basic validation

**Goal:**  
👉 Detect bugs early and fix issues before they grow.

---

## Continuous Delivery (CD)

Continuous Delivery comes **after integration**.

**What happens here:**
- The build process is automated.
- Higher-level testing is performed.
- Multiple features may be tested together.
- The application is packaged and prepared for release.

**Goal:**  
👉 Always keep the software in a **deployable state**.

> The software may not be deployed automatically, but it is always ready.

---

## Continuous Deployment (CD)

Continuous Deployment takes automation **one step further**.

**Key characteristics:**
- No human intervention
- Fully automated release to production
- Tests and validations decide deployment

**Goal:**  
👉 Release software **quickly, reliably, and repeatedly**.

This allows teams to focus more on feature development instead of manual releases.

---

## Bitbucket Pipelines Overview

**Bitbucket Pipelines** is a built-in CI/CD tool that automates:
- Code integration
- Testing
- Build processes
- Deployment workflows

It helps teams implement CI/CD without external tools.

---

## Understanding Bitbucket Pipeline Limits (Free Tier)

Bitbucket’s Free Tier is generous for learning and small teams but has limits.

### Free Tier Includes:
- **Unlimited public & private repositories**
  - For individuals and teams with **less than 5 members**
- **1 GB Large File Storage (LFS)**
  - Used for large binary files
- **50 build minutes per month**
  - Shared across all team members

### Important Note:
- Extra storage or build minutes require a **paid plan**.
- Free tier is sufficient for practice and small projects.

---
