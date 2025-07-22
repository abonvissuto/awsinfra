output "alb_dns_name" {
  description = "Load balancer endpoint to access the task"
  value       = aws_alb.application_load_balancer.dns_name
}

output "alb_zone_id" {
  description = "ALB zone id"
  value       = aws_alb.application_load_balancer.zone_id
}