terraform {
  backend "s3" {
    bucket       = "terraform-storage-config"
    key          = "dev/terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
    encrypt      = true
  }
}

module "gateway_bucket" {
  source      = "../modules/s3"
  bucket_name = "genailab-lambda-bucket"
}

data "aws_iam_role" "lambda_role" {
  name = "LambdaExecutionRoleBedrockAccess"
}

resource "aws_s3_object" "lambda_code" {
  depends_on     = [module.gateway_bucket]
  content_base64 = sensitive(filebase64("../artifacts/lambda.zip")) #not sensitive but avoids STDOUT print
  bucket         = module.gateway_bucket.bucket_id
  key            = "bedrock/lambda.zip"
}

module "bedrock_gateway" {
  source              = "../modules/lambda"
  depends_on          = [module.gateway_bucket, aws_s3_object.lambda_code]
  function_name       = "bedrock-gateway"
  role_arn            = data.aws_iam_role.lambda_role.arn
  runtime             = "python3.11"
  handler             = "api.app.handler"
  s3_bucket           = module.gateway_bucket.bucket_id
  s3_key              = "bedrock/lambda.zip"
  memory_size         = 128
  timeout             = 60
  create_function_url = true
  environment_variables = {
    API_KEY = sensitive(var.gateway_secret)
    DEBUG   = false
    PORT    = 80
  }
}

locals {
  merged_envs = merge(local.openwebui_env,
    {
      OPENAI_API_BASE_URL = sensitive(join(";", ["https://api.openai.com/v1", "${module.bedrock_gateway.lambda_url}api/v1"]))
      OPENAI_API_KEYS     = sensitive(join(";", ["", var.gateway_secret]))
    }
  )
}

module "openwebui" {
  source                         = "../modules/ecs"
  app_cluster_name               = local.openwebui_app_cluster_name
  app_task_family                = local.openwebui_app_task_family
  app_task_name                  = local.openwebui_app_task_name
  app_service_name               = local.openwebui_app_service_name
  application_load_balancer_name = local.openwebui_app_load_balancer_name
  availability_zones             = local.openwebui_availability_zones
  container_port                 = local.openwebui_container_port
  container_image                = local.openwebui_container_image # module.ecr_registry.repository_url
  ecs_task_execution_role_name   = local.openwebui_ecs_task_execution_role_name
  health_check_endpoint          = local.openwebui_health_check_endpoint
  target_group_name              = local.openwebui_target_group_name
  environment_variables          = local.merged_envs
  max_memory                     = 1024
  max_cpu                        = 256
}


module "battleground" {
  source                         = "../modules/ecs"
  app_cluster_name               = local.battleground_app_cluster_name
  app_task_family                = local.battleground_app_task_family
  app_task_name                  = local.battleground_app_task_name
  app_service_name               = local.battleground_app_service_name
  application_load_balancer_name = local.battleground_app_load_balancer_name
  availability_zones             = local.battleground_availability_zones
  container_port                 = local.battleground_container_port
  container_image                = local.battleground_container_image # module.ecr_registry.repository_url
  ecs_task_execution_role_name   = local.battleground_ecs_task_execution_role_name
  health_check_endpoint          = local.battleground_health_check_endpoint
  target_group_name              = local.battleground_target_group_name
  environment_variables          = local.battleground_env
  max_memory                     = 1024
  max_cpu                        = 256
}
