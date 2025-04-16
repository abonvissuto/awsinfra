# resource "aws_iam_role" "lambda_exec_role" {
#   name = "${var.function_name}_execution_role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = "sts:AssumeRole",
#         Effect = "Allow",
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         }
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
#   role       = aws_iam_role.lambda_exec_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
# }

# modules/lambda_function/main.tf
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

# resource "aws_lambda_function" "this" {
#   function_name    = var.function_name
#   role             = aws_iam_role.lambda_exec_role.arn
#   handler          = var.handler
#   runtime          = var.runtime
#   filename         = var.filename
#   source_code_hash = filebase64sha256(var.filename)
#   timeout          = var.timeout
#   memory_size      = var.memory_size
#   environment {
#     variables = var.environment_variables
#   }
# }

resource "aws_lambda_function_url" "this" {
  count              = var.create_function_url ? 1 : 0
  function_name      = aws_lambda_function.this.function_name
  authorization_type = var.url_auth_type
}
