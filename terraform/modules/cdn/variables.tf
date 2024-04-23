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

variable "website_bucket_name_main" {
  description = "The website's main bucket name. For example: timmytandian.com."
  type        = string
}

variable "website_bucket_name_www" {
  description = "The website's www bucket name. For example: www.timmytandian.com."
  type        = string
}

variable "referer_custom_header" {
  description = "The referer custom header to make sure that S3 is only accessible from CDN. This value is considered as sensitive."
  type = string
  sensitive = true
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate to be linked with the CDN."
  type = string
}

variable "lambda_edge_input_file" {
  description = "The input file path that will be zipped as lambda package."
  type = string
}

variable "lambda_edge_iam_role" {
  description = "Friendly name of IAM role to be assumed by Lambda Edge."
  type = string
  default = "LambdaEdge_CloudFrontSecurityHeader_ExecutionRole"
}

variable "env" {
  description = "The name of environment (dev/prod) to apply."
  type        = string
}
