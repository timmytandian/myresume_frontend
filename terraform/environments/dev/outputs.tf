output "static_website_name_main" {
  value = module.static_web.main_static_website_name
}

output "static_website_name_www_subdomain" {
  value = module.static_web.www_subdomain_static_website_name
}

output "ssl_certificate_arn" {
  value = module.dns.certificate_arn
}