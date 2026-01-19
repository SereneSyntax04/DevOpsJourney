terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}


module "network" {
  source       = "./modules/network"
  network_name = "${var.env}-network"
}

module "app" {
  source         = "./modules/app"
  container_name = "${var.env}-nginx"
  network_name   = module.network.network_name
  host_port      = var.host_port
}
