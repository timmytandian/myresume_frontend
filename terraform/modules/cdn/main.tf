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
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "origin-${var.website_bucket_name_main}"
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
  }

  aliases = [var.website_bucket_name_main, var.website_bucket_name_www]
  comment = "My cloud resume CDN for ${var.env} environment. Managed from Terraform."
  price_class = "PriceClass_100"
  enabled             = true
  is_ipv6_enabled     = false
  default_root_object = "index.html"

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = var.certificate_arn
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}