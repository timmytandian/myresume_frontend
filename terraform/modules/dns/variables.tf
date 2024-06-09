# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "hosted_zone_name" {
  description = "The hosted zone name for Route 53. E.g. timmytandian.com."
  type        = string
}

variable "main_domain" {
  description = "The main domain name to be registered as A record in Route 53. E.g. dev.timmytandian.com"
  type = string
}

variable "www_domain" {
  description = "The www sub domain name to be registered as A record in Route 53. E.g. www.dev.timmytandian.com"
  type = string
}

variable "cdn_hosted_zone_id" {
  description = "CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to."
  type = string
}

variable "cdn_domain_name" {
  description = "Domain name corresponding to the distribution. For example: d604721fxaaqy9.cloudfront.net."
  type = string
}

variable "env" {
  description = "The name of environment (dev/prod) to apply."
  type        = string
}