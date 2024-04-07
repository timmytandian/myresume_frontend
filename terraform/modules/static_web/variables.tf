# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "website_bucket_name" {
  description = "The bucket name for the website. This is also become the website name."
  type        = string
}

variable "website_resource_source_directory" {
  description = "A path of directory containing static website resource to be stored in S3 website."
  type        = string
}

variable "env" {
  description = "The name of environment (dev/prod) to apply."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------

variable "s3_block_public_acls" {
  description = "Whether Amazon S3 should block public access to buckets and objects granted through NEW access control lists (ACLs)."
  type        = bool
  default     = "false"
}

variable "s3_ignore_public_acls" {
  description = "Whether Amazon S3 should block public access to buckets and objects granted through ANY access control lists (ACLs)"
  type        = bool
  default     = "false"
}

variable "s3_block_public_policy" {
  description = "Whether Amazon S3 should block public access to buckets and objects granted through NEW public bucket or access point policies."
  type        = bool
  default     = "false"
}

variable "s3_restrict_public_buckets" {
  description = "Whether Amazon S3 should block public and cross-account access to buckets and objects through ANY public bucket or access point policies."
  type        = bool
  default     = "false"
}