# there are two blocks, one for what providers are required and another for each provider specific config. 
# Whenever you add a provider it is important to run "terraform init"  which will download plugins associated with the provider.
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}


locals {
  ports = {
    dev  = 8080
    prod = 9090
  }
}

module "nginx" {
  source        = "./modules/nginx"
  external_port = local.ports[terraform.workspace]

  providers = {
    docker = docker
  }
}
