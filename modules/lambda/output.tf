output "lambda_url" {
  value = aws_lambda_function_url.this[0].function_url
}