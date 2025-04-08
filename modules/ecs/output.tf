output "application_dns_name" {
  description = "Load balancer endpoint to access the task"
  value       = aws_alb.application_load_balancer.dns_name
}