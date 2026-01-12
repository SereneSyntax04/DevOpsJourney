terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}


# Pull Docker Image
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

# Run Docker Container
resource "docker_container" "nginx" {
  name  = "nginx_${terraform.workspace}" #terraform.workspace → dynamic naming per environment
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = var.external_port
  }
}
