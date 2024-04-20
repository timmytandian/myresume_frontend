output "certificate_arn" {
  value       = aws_acm_certificate.ssl_certificate.arn
  description = "the ARN of the SSL certificate"
}