module "local_files" {
  source = "../modules/local_files"

  text  = var.text
  text2 = var.text2
}


# steps to perform local task:
/*
step 1: copy the files in your local machine (git: clone...)
step 2: cd to IAC/localPractise/dev
step 3: 
terraform init
terraform plan
terraform apply --auto-approve
terraform destroy --auto-approve
rm -rf .terraform .terraform.lock.hcl terraform.tfstate terraform.tfstate.backup
*/
