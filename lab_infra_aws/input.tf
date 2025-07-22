variable "gateway_secret" {
  description = "Gateway AUTH secret"
  type        = string
}

variable "openwebui_admin_user_email" {
  description = "Default admin email"
  type        = string
}

variable "openwebui_admin_user_password" {
  description = "Default admin password"
  type        = string
}

variable "domain_name" {
  description = "Value of the domain you own (e.g. mycorp.example)"
  type        = string
}

variable "deployment_stage" {
  description = "Deployment stage (e.g. 'dev', 'stage', 'prod')"
  type        = string
}