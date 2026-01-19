terraform {
  required_version = ">= 1.3.0"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# (READ ONLY)
data "docker_image" "nginx" {
  name = "nginx:latest"
}


# (CREATE)
resource "docker_container" "nginx" {
  name  = var.container_name
  image = data.docker_image.nginx.id

  ports {
    internal = 80
    external = var.host_port
  }
}


