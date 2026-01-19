output "nginx_image_name" {
  value = data.docker_image.nginx.name
}

output "nginx_image_digest" {
  value = data.docker_image.nginx.repo_digest
}

output "container_id" {
  value = docker_container.nginx.id
}
