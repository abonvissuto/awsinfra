variable "bucket_name" {
  type        = string
  description = "Name of the bucket"
}
variable "object_lock_enabled" {
  type        = bool
  description = "Enable file locking. Default false"
  default     = false
}