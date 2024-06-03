variable "secret_referer_custom_header" {
  description = "The referer custom header to make sure that S3 is only accessible from CDN. This value is considered as sensitive."
  type = string
  sensitive = true
}