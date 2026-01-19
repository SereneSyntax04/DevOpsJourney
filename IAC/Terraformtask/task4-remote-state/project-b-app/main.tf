terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

data "terraform_remote_state" "network" {
  backend = "local"

  config = {
    path = "../project-a-network/terraform.tfstate"
  }
}

resource "docker_container" "app" {
  name  = "app_container"
  image = "nginx:latest"

  networks_advanced {
    name = data.terraform_remote_state.network.outputs.network_name
  }

  ports {
    internal = 80
    external = 8085
  }
}
