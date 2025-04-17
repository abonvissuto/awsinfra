output "ecs_cluster_output" {
  value = module.ecsCluster.application_dns_name
}

output "bedrock_gateway" {
  value = module.bedrock_gateway.lambda_url
}