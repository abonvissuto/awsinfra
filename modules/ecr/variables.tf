variable "ecr_repository_name" {
  description = "Name of the ECR registry to be created"
  type        = string
}

variable "force_delete" {
  description = "Force deletion"
  type        = bool
  default     = false
}