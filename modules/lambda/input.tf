variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "handler" {
  description = "Lambda function handler"
  type        = string
}

variable "runtime" {
  description = "Runtime to use for the Lambda function"
  type        = string
}

variable "timeout" {
  description = "Function execution timeout in seconds"
  type        = number
  default     = 3
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use"
  type        = number
  default     = 128
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "create_function_url" {
  description = "Whether to create a Function URL for the Lambda"
  type        = bool
  default     = false
}

variable "url_auth_type" {
  description = "Authorization type for Lambda URL"
  type        = string
  default     = "NONE"
}

variable "role_arn" {
  description = "ARN of the lamda execution role"
  type        = string
}

variable "s3_bucket" {
  description = "ARN of the s3 bucket where the code resides"
  type        = string
}

variable "s3_key" {
  description = "Key to locate the zip file within the s3 bucket"
  type        = string
}