# locals {
#   app_cluster_name               = "hello-world-cluster"
#   app_task_family                = "hello-world"
#   app_task_name                  = "hello-world"
#   app_service_name               = "hello-world-service"
#   application_load_balancer_name = "hello-world-alb"
#   availability_zones             = ["eu-west-2"]
#   container_port                 = 8080
#   container_image                = "lejipo/hello-world"
#   ecs_task_execution_role_name   = "ECSTaskExecutionRole"
#   target_group_name              = "hello-world-alb-group"
# }
locals {
  openwebui_app_cluster_name             = "openwebui-cluster"
  openwebui_app_task_family              = "openwebui"
  openwebui_app_task_name                = "openwebui"
  openwebui_app_service_name             = "openwebui-service"
  openwebui_app_load_balancer_name       = "openwebui-alb"
  openwebui_availability_zones           = ["eu-west-2"]
  openwebui_container_port               = 8080
  openwebui_container_image              = "lejipo/openweb-custom"
  openwebui_ecs_task_execution_role_name = "ECSTaskExecutionRole"
  openwebui_target_group_name            = "openwebui-alb-group"
  openwebui_health_check_endpoint        = "/health"
  openwebui_env = {
    ENV                 = "prod"
    ADMIN_USER_EMAIL    = sensitive(var.openwebui_admin_user_email)
    ADMIN_USER_PASSWORD = sensitive(var.openwebui_admin_user_password)
    ENABLE_SIGNUP       = false
  }

  battleground_app_cluster_name             = "battleground-cluster"
  battleground_app_task_family              = "battleground"
  battleground_app_task_name                = "battleground"
  battleground_app_service_name             = "battleground-service"
  battleground_app_load_balancer_name       = "battleground-alb"
  battleground_availability_zones           = ["eu-west-2"]
  battleground_container_port               = 3000
  battleground_container_image              = "lejipo/battleground"
  battleground_ecs_task_execution_role_name = "ECSTaskExecutionRole"
  battleground_target_group_name            = "battleground-alb-group"
  battleground_health_check_endpoint        = "/health"
  battleground_env = {
    DEFAULT_USER_EMAIL    = sensitive(var.openwebui_admin_user_email)
    DEFAULT_USER_PASSWORD = sensitive(var.openwebui_admin_user_password)
    DEFAULT_USER_USERNAME = "Admin"

  }
}