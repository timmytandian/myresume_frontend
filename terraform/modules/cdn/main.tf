resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.bucket_regional_domain_name
    origin_id   = "origin-${var.website_bucket_name}"
    origin_access_control_id = aws_cloudfront_origin_access_control.s3_distribution.id
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
    actions = ["S3:GetObject"]
    sid    = "AllowCloudFrontServicePrincipalReadOnly"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    resources = [
      "${var.main_website_bucket_arn}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"

      values = [
        "${aws_cloudfront_distribution.s3_distribution.arn}"
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "s3_distribution" {
  bucket = var.main_website_bucket_id
  policy = data.aws_iam_policy_document.s3_distribution.json
}