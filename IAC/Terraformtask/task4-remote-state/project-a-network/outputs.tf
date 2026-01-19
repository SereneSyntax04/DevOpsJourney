output "network_name" {
  value = docker_network.shared_net.name
}

output "network_id" {
  value = docker_network.shared_net.id
}
