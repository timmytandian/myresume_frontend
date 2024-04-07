resource "aws_s3_bucket" "main_static_website" {
  bucket = "${var.env}.${var.website_bucket_name}"
}

resource "aws_s3_bucket_public_access_block" "main_static_website" {
  bucket = aws_s3_bucket.main_static_website.id

  block_public_acls       = false
  ignore_public_acls      = false
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
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "main_static_website" {
  bucket = aws_s3_bucket.main_static_website.id

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
  depends_on = [
    aws_s3_bucket_public_access_block.main_static_website,
    aws_s3_bucket_ownership_controls.main_static_website,
    aws_s3_bucket_acl.main_static_website,
  ]
  
  for_each     = fileset(var.website_resource_source_directory, "**/*.*")
  bucket       = aws_s3_bucket.main_static_website.bucket
  key          = replace(each.value, var.website_resource_source_directory, "")
  source       = "${var.website_resource_source_directory}${each.value}"
  acl          = "public-read"
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