terraform {
  backend "s3" {
    bucket         = "terraform-tfstate-cloudresume"
    key            = "frontend/dev_src/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-cloudresume-state-locking"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# Recursive upload of multiple files. Reference:
# https://acode.ninja/posts/recursive-file-upload-to-s3-in-terraform/

resource "aws_s3_bucket" "tf_resume_timmytandian" {
  bucket  = "tf-resume.timmytandian.com"

  #website {
  #  index_document = "index.html"
  #  error_document = "error.html"
  #}
  # The acl and website keywords below have been depreceated. 
  # See here to troubleshoot: https://discuss.hashicorp.com/t/handling-aws-s3-bucket-acl-deprecation/42288
}

resource "aws_s3_bucket_public_access_block" "tf_resume_timmytandian" {
  bucket = aws_s3_bucket.tf_resume_timmytandian.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "tf_resume_timmytandian" {
  bucket = aws_s3_bucket.tf_resume_timmytandian.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
  depends_on = [aws_s3_bucket_public_access_block.tf_resume_timmytandian]
}

resource "aws_s3_bucket_acl" "tf_resume_timmytandian" {
  depends_on = [
    aws_s3_bucket_ownership_controls.tf_resume_timmytandian,
    aws_s3_bucket_public_access_block.tf_resume_timmytandian,
  ]

  bucket = aws_s3_bucket.tf_resume_timmytandian.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "tf_resume_timmytandian" {
  bucket = aws_s3_bucket.tf_resume_timmytandian.id

  index_document {
    suffix = "index.html"
  }

  #routing_rule {
  #  condition {
  #    key_prefix_equals = "docs/"
  #  }
  #  redirect {
  #    replace_key_prefix_with = "documents/"
  #  }
  #}
}

resource "aws_s3_object" "website_files" {
  for_each      = fileset(local.upload_directory.default, "**/*.*")
  bucket        = aws_s3_bucket.tf_resume_timmytandian.bucket
  key           = replace(each.value, local.upload_directory.default, "")
  source        = "${local.upload_directory.default}${each.value}"
  acl           = "public-read"
  etag          = filemd5("${local.upload_directory.default}${each.value}")
  content_type  = lookup(local.mime_types.default, split(".", each.value)[length(split(".", each.value)) - 1])
}