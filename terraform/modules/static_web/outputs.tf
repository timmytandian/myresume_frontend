output "main_static_website_name" {
  value       = aws_s3_bucket.main_static_website.bucket
  description = "The s3 bucket name that stores the static website resource."
}

output "www_subdomain_static_website_name" {
  value       = aws_s3_bucket.subdomain_www_static_website.bucket
  description = "The s3 bucket with www in the bucket name and redirects all request to the main static website. This bucket doesn't store any website resource."
}