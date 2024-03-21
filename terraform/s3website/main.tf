terraform {
  backend "s3" {
    bucket         = "terraform-cloudresume-tfstate"
    key            = "frontend/dev_src/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-cloudresume-state-locking"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# Recursive upload of multiple files. Reference:
# https://acode.ninja/posts/recursive-file-upload-to-s3-in-terraform/

resource "aws_s3_bucket" "s3_static" {
  bucket  = "tf-resume.timmytandian.com"
  acl     = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  # The acl and website keywords below have been depreceated. 
  # See here to troubleshoot: https://discuss.hashicorp.com/t/handling-aws-s3-bucket-acl-deprecation/42288
}

variable "upload_directory" {
  default = "${path.cwd}/codebases/website-static/"
}

variable "mime_types" {
  default = {
    htm   = "text/html"
    html  = "text/html"
    css   = "text/css"
    ttf   = "font/ttf"
    js    = "application/javascript"
    map   = "application/javascript"
    json  = "application/json"
  }
}

resource "aws_s3_bucket_object" "website_files" {
  for_each      = fileset(var.upload_directory, "**/*.*")
  bucket        = aws_s3_bucket.s3_static.bucket
  key           = replace(each.value, var.upload_directory, "")
  source        = "${var.upload_directory}${each.value}"
  acl           = "public-read"
  etag          = filemd5("${var.upload_directory}${each.value}")
  content_type  = lookup(var.mime_types, split(".", each.value)[length(split(".", each.value)) - 1])
}