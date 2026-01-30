
# Steps to Perform Local Terraform Task

Follow the steps below to run and clean up the Terraform setup locally.

---

## Step 1: Clone the Repository

Copy the project files to your local machine:

```bash
git clone <repository-url>
```

---

## Step 2: Navigate to the Terraform Directory

Move into the local practice directory:

```bash
cd IAC/localPractise/dev
```

---

## Step 3: Initialize Terraform

Initialize the working directory and download required providers:

```bash
terraform init
```
<div style="display:flex; gap:10px;"> <img src="/IAC/localPractise/tskimg/init.png" width="400">  </div>

---

## Step 4: Review the Execution Plan

Check what Terraform is going to create or modify:

```bash
terraform plan
```
<div style="display:flex; gap:10px;"> <img src="/IAC/localPractise/tskimg/plan.png" width="400">  </div>

---

## Step 5: Apply the Configuration

Create the resources locally:

```bash
terraform apply --auto-approve
```
<div style="display:flex; gap:10px;"> <img src="/IAC/localPractise/tskimg/applyA.png" width="400"> 
<img src="/IAC/localPractise/tskimg/applyB.png" width="400" heigth="500"> <img src="/IAC/localPractise/tskimg/applyVerify.png" width="400"> </div>

---

## Step 6: Destroy the Resources

Clean up all the created resources:

```bash
terraform destroy --auto-approve
```

<div style="display:flex; gap:10px;"> <img src="/IAC/localPractise/tskimg/destroy.png" width="400"> </div>

---

## Step 7: Cleanup Terraform State Files

Remove Terraform-generated files to reset the workspace:

```bash
rm -rf .terraform .terraform.lock.hcl terraform.tfstate terraform.tfstate.backup
```

---

✅ Your local Terraform environment is now clean.
