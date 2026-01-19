variable "container_name" {
  description = "Name of the nginx container"
  type        = string
  default     = "nginx-data-demo"
}

variable "host_port" {
  description = "Host port to expose nginx"
  type        = number
  default     = 8083
}
