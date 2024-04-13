output "main_static_website_endpoint" {
  value       = aws_s3_bucket_website_configuration.main_static_website.website_endpoint
  description = "The WEBSITE ENDPOINT of the main s3 bucket."
}

output "main_static_website_name" {
  value       = aws_s3_bucket.main_static_website.bucket
  description = "The s3 bucket name that stores the static website resource."
}

output "main_static_website_regional_domain_name" {
  value       = aws_s3_bucket.main_static_website.bucket_regional_domain_name
  description = "The bucket region-specific domain name. The bucket domain name including the region name."
}

output "main_static_website_bucket_arn" {
  value       = aws_s3_bucket.main_static_website.arn
  description = "The arn of main s3 bucket."
}

output "main_static_website_bucket_id" {
  value       = aws_s3_bucket.main_static_website.id
  description = "The id of main s3 bucket."
}

output "www_subdomain_static_website_name" {
  value       = aws_s3_bucket.subdomain_www_static_website.bucket
  description = "The s3 bucket with www in the bucket name and redirects all request to the main static website. This bucket doesn't store any website resource."
}