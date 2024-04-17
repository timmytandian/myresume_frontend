resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.main_website_endpoint
    origin_id   = "origin-${var.website_bucket_name}"
    #origin_access_control_id = aws_cloudfront_origin_access_control.s3_distribution.id
    custom_origin_config {
      http_port = "80"
      https_port = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols = ["TLSv1.2"]
    }
    custom_header {
      name = "Referer"
      value = "${var.referer_custom_header}"
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "origin-${var.website_bucket_name}"
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
  }

  comment = "My cloud resume CDN for ${var.env} environment. Managed from Terraform."
  price_class = "PriceClass_100"
  enabled             = true
  is_ipv6_enabled     = false
  default_root_object = "index.html"
  #aliases = ["${local.sub_domain}.${data.aws_route53_zone.zone.name}"]

  viewer_certificate {
    cloudfront_default_certificate = true
    #acm_certificate_arn            = data.aws_acm_certificate.certificate.arn    
    #minimum_protocol_version       = "TLSv1.2_2021"
    #ssl_support_method             = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

resource "aws_cloudfront_origin_access_control" "s3_distribution" {
  name                              = "OAC for ${var.website_bucket_name}"
  description                       = "Origin access control for the ${var.website_bucket_name}, made with Terraform."
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

data "aws_iam_policy_document" "s3_distribution" {
  statement {
    actions = ["S3:GetObject","s3:GetObjectVersion"]
    sid    = "Allow only GET requests originating from CloudFront with specific Referer header"
    effect = "Allow"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    resources = [
      "${var.main_website_bucket_arn}/*",
    ]

    condition {
      test     = "StringLike"
      variable = "aws:Referer"

      values = [
        #"${aws_cloudfront_distribution.s3_distribution.origin.custom_header.value}"
        "${var.referer_custom_header}"
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "s3_distribution" {
  bucket = var.main_website_bucket_id
  policy = data.aws_iam_policy_document.s3_distribution.json
}
