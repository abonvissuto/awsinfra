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
  app_cluster_name               = "openwebui-cluster"
  app_task_family                = "openwebui"
  app_task_name                  = "openwebui"
  app_service_name               = "openwebui-service"
  application_load_balancer_name = "openwebui-alb"
  availability_zones             = ["eu-west-2"]
  container_port                 = 8080
  container_image                = "lejipo/openweb-custom"
  ecs_task_execution_role_name   = "ECSTaskExecutionRole"
  target_group_name              = "openwebui-alb-group"
  health_check_endpoint          = "/health"
  openwebui_env = {
    ENV                 = "prod"
    ADMIN_USER_EMAIL    = sensitive(var.openwebui_admin_user_email)
    ADMIN_USER_PASSWORD = sensitive(var.openwebui_admin_user_password)
    ENABLE_SIGNUP       = false
  }
}