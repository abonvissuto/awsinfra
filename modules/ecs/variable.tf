variable "app_cluster_name" {
  description = "ECS Cluster name"
  type        = string
}

variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
}

variable "app_task_family" {
  description = "ECS Task Family"
  type        = string
}

variable "container_image" {
  description = "Name of the DockerIO image or ECR Repo URL"
  type        = string
}

variable "container_port" {
  description = "Container Port"
  type        = number
}

variable "app_task_name" {
  description = "Name of the task"
  type        = string
}

variable "ecs_task_execution_role_name" {
  description = "ECS Task Execution Role Name"
  type        = string
}

variable "application_load_balancer_name" {
  description = "ALB Name"
  type        = string
}

variable "target_group_name" {
  description = "ALB Target Group Name"
  type        = string
}

variable "app_service_name" {
  description = "ECS Service Name"
  type        = string
}

variable "health_check_endpoint" {
  description = "Healthcheck path. Default '/'"
  type        = string
  default     = "/"
}

variable "max_memory" {
  description = "RAM amount for task. Default 512"
  default  = 512
}

variable "max_cpu" {
  description = "Max CPU usage. Default 0.25"
  default  = 256
}