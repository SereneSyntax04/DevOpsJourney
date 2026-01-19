terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_network" "this" {
  name = var.network_name
}



# This module:

# knows nothing about nginx

# reusable for any app

# clean responsibility
