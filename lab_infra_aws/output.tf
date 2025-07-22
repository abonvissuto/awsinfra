output "openwebui_cluster" {
  value = module.openwebui.alb_dns_name
}

output "battleground_cluster" {
  value = module.battleground.alb_dns_name
}

output "bedrock_gateway" {
  value = module.bedrock_gateway.lambda_url
}