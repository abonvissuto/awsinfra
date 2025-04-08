resource "aws_ecr_repository" "container_registry" {
  name = var.ecr_repository_name
  tags = {
    environment : "dev"
  }
  force_delete = var.force_delete
}