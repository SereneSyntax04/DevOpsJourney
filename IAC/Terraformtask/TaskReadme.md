# list of terraform task executed.
```
Terraformtask/
├── task1-workspaces-nginx/        
├── task2-multi-container/
├── task3-data-sources/
├── task4-remote-state/
├── task5-count-for_each/
├── task6-null-resource-provisioner/
├── task7-module-composition/
├── task8-localstack-advanced/     (optional revisit)
```

- [Understanding workspace in terraform](/IAC/Terraformtask/task1-workspaces-nginx/task1Readme.md)

- [Understanding multi container](/IAC/Terraformtask/task2-multi-container/task2Readme.md)

- [Understanding data sources](/IAC/Terraformtask/task3-data-sources/task3Readme.md)










```
🧩 TASK 4 — Remote State (Still Local)

Goal: Understand how teams share Terraform outputs.

What you’ll build

Project A creates Docker network

Project B reads that network via remote state

Both local backend (no cloud)

Concepts

terraform_remote_state

Output consumption

State isolation

Cross-project wiring

Why this matters

This is exactly how real infra stacks talk to each other.

🧩 TASK 5 — count vs for_each (Critical Skill)

Goal: Stop guessing and actually understand iteration.

What you’ll build

Create multiple containers

One using count

One using for_each

Rename and destroy selectively

Concepts

Index vs key

Why for_each is safer

State addressing

Destroy drift problems

Reality check

Anyone who doesn’t understand this will break prod infra someday.

🧩 TASK 6 — null_resource + Provisioners

Goal: Learn what Terraform should and should NOT do.

What you’ll build

Run shell commands

Create local files

Trigger rebuilds on change

Concepts

null_resource

local-exec

triggers

Why provisioners are “last resort”

Elder brother advice

Use this to learn — avoid in real infra unless unavoidable.

🧩 TASK 7 — Module Composition (Advanced but Gold)

Goal: Learn how real Terraform repos are structured.

What you’ll build

Base module → network

App module → nginx

Root module wires both

Outputs passed between modules

Concepts

Module outputs

Module inputs

Provider inheritance

Reusability

This turns you from student → Terraform engineer.

🧩 TASK 8 — LocalStack Advanced (Optional Revisit)

You already did:

VPC

Subnets

Bastion

Now improve it:

Split into modules

Use variables properly

Use outputs + data sources

Remote state between modules

Ignore ELB limitation — plan output still teaches graph logic.
```