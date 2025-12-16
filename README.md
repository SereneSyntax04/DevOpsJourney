# learning-devops
My DevOps learning journey with structured notes and practical insights, starting with Foundations of DevOps and expanding into real-world tools and workflows.


# Terraform Submodule

This repository includes a Terraform project as a **submodule**.  

- The submodule is located at: `terraform-infra/AWS-infrastructure-using-Terraform`
- On GitHub, you’ll only see a pointer to the submodule, not the actual files. To view the files online, visit the original repo: [AWS-infrastructure-using-Terraform](https://github.com/SereneSyntax04/AWS-infrastructure-using-Terraform)


### After Cloning

After cloning this `devops` repo, make sure to fetch the submodule files with:

```bash
git submodule update --init --recursive
```
If you already have the submodule folder locally, you can open and work with the files directly — no extra commands are needed.

## Updating the Submodule

If the Terraform submodule gets updated, you can pull the latest changes by:

```bash
cd terraform-infra/AWS-infrastructure-using-Terraform
git pull origin main
cd ../..
git add terraform-infra/AWS-infrastructure-using-Terraform
git commit -m "Updated Terraform submodule"
git push
```