variable "role_arn" {
    
}

variable "task_family" {
  type = string
  sensitive = true
}

variable "cluster_name" {
  type = string
}

variable "docker_container_name" {
  type = string
}

variable "docker_image" {
  type = string
}

variable "container_port" {
  
}