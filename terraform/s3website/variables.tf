# General Variables

variable "region" {
  description = "Default region for provider"
  type        = string
  default     = "ap-northeast-1"
}

locals {
  upload_directory = {
    description = "The directory where its content will be uploaded to S3 bucket"
    default = "${path.cwd}/../../src/"
  }

  mime_types = {
    description = "Possibilities of a files mime types"
    default = {
      htm   = "text/html"
      html  = "text/html"
      css   = "text/css"
      ttf   = "font/ttf"
      js    = "application/javascript"
      map   = "application/javascript"
      json  = "application/json"
      jpg   = "image/jpeg"
      jpeg  = "image/jpeg"
      png   = "image/png"
      ico   = "image/vnd.microsoft.icon"
    }
  }
}