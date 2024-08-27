output "static_website_name_main" {
  value = module.static_web.main_static_website_name
  description = "The s3 bucket name that stores the static website resource. This is the main bucket."
}

output "static_website_name_www_subdomain" {
  value = module.static_web.www_subdomain_static_website_name
  description = "The s3 bucket name that stores the www.domain of the website resource. Content mirrors the main bucket."
}

output "ssl_certificate_arn" {
  value = module.dns.certificate_arn
  description = "The ARN of the SSL certificate."
}

output "cdn_id" {
  value       = module.cdn.cdn_id
  description = "Identifier for the content distribution network."
}

output "cdn_status" {
  value       = module.cdn.cdn_status
  description = "Current status of the content distribution network."
}

output "cdn_last_modified_time" {
  value       = module.cdn.cdn_last_modified_time
  description = "Date and time the content distribution network was last modified."
}