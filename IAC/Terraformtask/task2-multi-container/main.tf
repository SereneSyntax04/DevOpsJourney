terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "app_net" {
  name = "app_network"
}
resource "docker_container" "redis" {
  name  = "redis"
  image = "redis:7"

  networks_advanced {
    name = docker_network.app_net.name
  }
}

resource "docker_container" "nginx" {
  name  = "nginx"
  image = "nginx:latest"

  ports {
    internal = 80
    external = var.nginx_port

  }

  networks_advanced {
    name = docker_network.app_net.name
  }
}
