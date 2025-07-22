output "arn" {
  value = aws_acm_certificate_validation.wildcard_cert_validation.certificate_arn
}