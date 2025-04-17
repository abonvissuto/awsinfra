resource "aws_lambda_function" "this" {
  function_name = var.function_name
  role          = var.role_arn
  runtime       = var.runtime
  handler       = var.handler
  timeout       = var.timeout
  memory_size   = var.memory_size

  s3_bucket = var.s3_bucket
  s3_key    = var.s3_key

  environment {
    variables = var.environment_variables
  }
}

resource "aws_lambda_function_url" "this" {
  count              = var.create_function_url ? 1 : 0
  function_name      = aws_lambda_function.this.function_name
  authorization_type = var.url_auth_type
}
