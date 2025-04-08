terraform {
  backend "s3" {
    bucket       = "terraform-storage-config"
    key          = "dev/terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
    encrypt      = true
  }
}


# module "ecr_registry" {
#   source              = "../modules/ecr"
#   ecr_repository_name = local.ecr_repository_name
# }

# TEST HELLO WORLD 
# module "ecsCluster" {
#   source                         = "../modules/ecs"
#   app_cluster_name               = local.app_cluster_name
#   app_task_family                = local.app_task_family
#   app_task_name                  = local.app_task_name
#   app_service_name               = local.app_service_name
#   application_load_balancer_name = local.application_load_balancer_name
#   availability_zones             = local.availability_zones
#   container_port                 = local.container_port
#   container_image                = local.container_image # module.ecr_registry.repository_url
#   ecs_task_execution_role_name   = local.ecs_task_execution_role_name
#   target_group_name              = local.target_group_name
# }

# module "gateway_bucket" {
#   source = "../modules/s3"
#   bucket_name = "bedrock-gateway"
# }

module "ecsCluster" {
  source                         = "../modules/ecs"
  app_cluster_name               = local.app_cluster_name
  app_task_family                = local.app_task_family
  app_task_name                  = local.app_task_name
  app_service_name               = local.app_service_name
  application_load_balancer_name = local.application_load_balancer_name
  availability_zones             = local.availability_zones
  container_port                 = local.container_port
  container_image                = local.container_image # module.ecr_registry.repository_url
  ecs_task_execution_role_name   = local.ecs_task_execution_role_name
  target_group_name              = local.target_group_name
  max_memory = 1024
  max_cpu = 256
}

output "ecs_cluster_output" {
  value = module.ecsCluster.application_dns_name
}