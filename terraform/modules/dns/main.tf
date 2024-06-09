# The main Route 53 hosted zone
data "aws_route53_zone" "zone" {
  name      = var.hosted_zone_name
  private_zone = false
}

# SSL certificate and DNS record for its validation
resource "aws_acm_certificate" "ssl_certificate" {
  domain_name               = var.hosted_zone_name
  //subject_alternative_names = ["${var.main_domain}", "${var.www_domain}"]
  subject_alternative_names = ["${var.main_domain}", format("%s%s","*.","${var.main_domain}")]
  validation_method = "DNS"
  key_algorithm = "EC_prime256v1"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "ssl_certificate" {
  certificate_arn = aws_acm_certificate.ssl_certificate.arn
}

resource "aws_route53_record" "ssl_certificate" {
  for_each = {
    for dvo in aws_acm_certificate.ssl_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.zone.zone_id
}

# DNS record for the website
resource "aws_route53_record" "main" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "${var.main_domain}"
  type    = "A"

  alias {
    name                   = var.cdn_domain_name
    zone_id                = var.cdn_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "${var.www_domain}"
  type    = "A"

  alias {
    name                   = var.cdn_domain_name
    zone_id                = var.cdn_hosted_zone_id
    evaluate_target_health = false
  }
}