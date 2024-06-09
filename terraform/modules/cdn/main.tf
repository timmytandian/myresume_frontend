resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = var.main_website_endpoint
    origin_id   = "origin-${var.website_bucket_name_main}"
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
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "origin-${var.website_bucket_name_main}"
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = data.aws_cloudfront_cache_policy.s3_distribution.id
    compress               = true 
    lambda_function_association {
      event_type   = "origin-response"
      lambda_arn   = aws_lambda_function.lambda_edge.qualified_arn
      include_body = false
    }
  }

  aliases             = [var.website_bucket_name_main, var.website_bucket_name_www]
  comment             = "My cloud resume CDN for ${var.env} environment. Managed from Terraform."
  http_version        = "http2and3"
  is_ipv6_enabled     = true
  price_class         = "PriceClass_100"
  enabled             = true
  default_root_object = "index.html"
  provider            = aws.use1

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = var.certificate_arn
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }

  logging_config {
    bucket          = data.aws_s3_bucket.s3_distribution_logs.id
    prefix          = "cdn_logs/"
    include_cookies = false
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

data "aws_cloudfront_cache_policy" "s3_distribution" {
  name = "Managed-CachingOptimized"
  provider = aws.use1
}

# for logging purpose
data "aws_s3_bucket" "s3_distribution_logs" {
  bucket = "logs.timmytandian.com"
  provider = aws.apne1
}