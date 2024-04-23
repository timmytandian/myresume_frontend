###################################################
# Bucket: main_static_website
###################################################

resource "aws_s3_bucket" "main_static_website" {
  # If the environment is prod, set the bucket name to be example.com
  # If the environemnt is dev, set the bucket name to be dev.example.com
  bucket = "${var.env == "prod" ? "" : "${var.env}."}${var.website_bucket_name}"
  
  # Set the force_destroy to be false if we are in prod environment
  # Otherwise, it is okay to force destroy the content when the bucket is destroyed
  force_destroy = var.env == "prod" ? false : true
}

resource "aws_s3_bucket_versioning" "main_static_website" {
  bucket = aws_s3_bucket.main_static_website.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main_static_website" {
  bucket        = aws_s3_bucket.main_static_website.bucket 
  
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "main_static_website" {
  bucket = aws_s3_bucket.main_static_website.id

  block_public_acls       = false
  ignore_public_acls      = true
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "main_static_website" {
  depends_on = [aws_s3_bucket_public_access_block.main_static_website]
  
  bucket = aws_s3_bucket.main_static_website.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "main_static_website" {
  depends_on = [
    aws_s3_bucket_public_access_block.main_static_website,
    aws_s3_bucket_ownership_controls.main_static_website,
  ]

  bucket = aws_s3_bucket.main_static_website.id
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "main_static_website" {
  bucket = aws_s3_bucket.main_static_website.id

  index_document {
    suffix = "index.html"
  }
}

data "aws_iam_policy_document" "main_static_website" {
  statement {
    actions = ["s3:GetObject","s3:GetObjectVersion"]
    sid    = "Allow only GET requests originating from CloudFront with specific Referer header"
    effect = "Allow"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    resources = [
      "${aws_s3_bucket.main_static_website.arn}/*",
    ]

    condition {
      test     = "StringLike"
      variable = "aws:Referer"

      values = [
        "${var.referer_custom_header}"
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "main_static_website" {
  bucket = aws_s3_bucket.main_static_website.id
  policy = data.aws_iam_policy_document.main_static_website.json
}

resource "aws_s3_object" "website_files" {
  depends_on = [
    aws_s3_bucket_public_access_block.main_static_website,
    aws_s3_bucket_ownership_controls.main_static_website,
    aws_s3_bucket_acl.main_static_website,
  ]
  
  for_each     = fileset(var.website_resource_source_directory, "**/*.*")
  bucket       = aws_s3_bucket.main_static_website.bucket
  key          = replace(each.value, var.website_resource_source_directory, "")
  source       = "${var.website_resource_source_directory}${each.value}"
  #acl          = "public-read"
  etag         = filemd5("${var.website_resource_source_directory}${each.value}")
  content_type = lookup(local.mime_types, split(".", each.value)[length(split(".", each.value)) - 1])
}

locals {
  mime_types = {
    htm  = "text/html"
    html = "text/html"
    css  = "text/css"
    ttf  = "font/ttf"
    js   = "application/javascript"
    map  = "application/javascript"
    json = "application/json"
    jpg  = "image/jpeg"
    jpeg = "image/jpeg"
    png  = "image/png"
    ico  = "image/vnd.microsoft.icon"
  }
}

###################################################
# Bucket: subdomain_www_static_website
###################################################

resource "aws_s3_bucket" "subdomain_www_static_website" {
  # If the environment is prod, set the bucket name to be example.com
  # If the environemnt is dev, set the bucket name to be dev.example.com
  bucket = "www.${var.env == "prod" ? "" : "${var.env}."}${var.website_bucket_name}"

}

resource "aws_s3_bucket_versioning" "subdomain_www_static_website" {
  bucket = aws_s3_bucket.subdomain_www_static_website.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "subdomain_www_static_website" {
  bucket        = aws_s3_bucket.subdomain_www_static_website.bucket 
  
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "subdomain_www_static_website" {
  bucket = aws_s3_bucket.subdomain_www_static_website.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "subdomain_www_static_website" {
  depends_on = [aws_s3_bucket_public_access_block.subdomain_www_static_website]
  
  bucket = aws_s3_bucket.subdomain_www_static_website.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_website_configuration" "subdomain_www_static_website" {
  bucket = aws_s3_bucket.subdomain_www_static_website.id

  redirect_all_requests_to {
    host_name = aws_s3_bucket_website_configuration.main_static_website.website_endpoint
    protocol = "http"
  }
}