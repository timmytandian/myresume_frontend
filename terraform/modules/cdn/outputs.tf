output "cdn_id" {
  value       = aws_cloudfront_distribution.s3_distribution.id
  description = "Identifier for the content distribution network."
}

output "cdn_status" {
  value       = aws_cloudfront_distribution.s3_distribution.status
  description = "Current status of the distribution."
}

output "cdn_domain_name" {
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
  description = "Domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net."
}

output "cdn_last_modified_time" {
  value       = aws_cloudfront_distribution.s3_distribution.last_modified_time
  description = "Date and time the distribution was last modified."
}

output "cdn_hosted_zone_id" {
  value       = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
  description = "CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to."
}