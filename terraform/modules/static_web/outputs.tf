output "main_static_website_name" {
  value       = aws_s3_bucket.main_static_website.bucket
  description = "The s3 bucket name that stores the static website resource."
}