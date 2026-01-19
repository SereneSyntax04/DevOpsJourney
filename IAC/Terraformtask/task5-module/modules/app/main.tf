terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

resource "docker_container" "nginx" {
  name  = var.container_name
  image = "nginx:latest"

  ports {
    internal = 80
    external = var.host_port
  }

  networks_advanced {
    name = var.network_name
  }
}



# Notice:

# app module does NOT create network
