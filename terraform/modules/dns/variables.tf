# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------

variable "hosted_zone_name" {
  description = "The hosted zone name for Route 53. E.g. timmytandian.com."
  type        = string
}

variable "certificate_domain" {
  description = "The certificate domain name."
  type = string
}

variable "sub_domain" {
  description = "The sub domain name to be registered as A record in Route 53."
  type = string
}

variable "env" {
  description = "The name of environment (dev/prod) to apply."
  type        = string
}