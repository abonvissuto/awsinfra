resource "aws_s3_bucket" "terraform_state" {
  bucket              = var.default_config_bucket
  object_lock_enabled = true
  force_destroy       = true # allows to destroy the bucket even if contains files 
}