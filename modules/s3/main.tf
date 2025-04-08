resource "aws_s3_bucket" "bucket" {
  bucket              = var.bucket_name
  object_lock_enabled = var.object_lock_enabled
  force_destroy       = true # allows to destroy the bucket even if contains files 
}