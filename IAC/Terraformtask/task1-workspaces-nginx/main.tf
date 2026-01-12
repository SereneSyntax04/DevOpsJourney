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
