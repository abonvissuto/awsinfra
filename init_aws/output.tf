output "configuration_bucket" {
  description = "Configuration bucket used to store all the state of the infrastructure"
  value = aws_s3_bucket.terraform_state.arn
}