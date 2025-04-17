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

resource "aws_s3_object" "lambda_code" {
  content_base64 = sensitive(filebase64("../artifacts/lambda.zip")) #not sensitive but avoids STDOUT print
  bucket         = module.gateway_bucket.bucket_id
  key            = "bedrock/lambda.zip"
}

data "aws_iam_role" "lambda_role" {
  name = "LambdaExecutionRoleBedrockAccess"
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
  health_check_endpoint          = local.health_check_endpoint
  target_group_name              = local.target_group_name
  environment_variables          = local.merged_envs
  max_memory                     = 1024
  max_cpu                        = 256
}
