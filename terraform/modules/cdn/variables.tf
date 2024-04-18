# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "bucket_regional_domain_name" {
  description = "The bucket region-specific domain name. The bucket domain name including the region name. E.g. s3.ap-northeast-1.amazonaws.com."
  type        = string
}

variable "main_website_endpoint" {
  description = "The website endpoint of the main s3 bucket to be set as origin domain."
  type = string
}

variable "website_bucket_name" {
  description = "The bucket name for the website. This is also become the website name."
  type        = string
}

variable "referer_custom_header" {
  description = "The referer custom header to make sure that S3 is only accessible from CDN. This value is considered as sensitive."
  type = string
  sensitive = true
}

variable "env" {
  description = "The name of environment (dev/prod) to apply."
  type        = string
}
