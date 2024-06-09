# Use the block below to import the resource from AWS
# IMPORTANT: after the import procedure finished, the code below should be commented out.

###################################################
# SSL certificate and DNS record for its validation
###################################################
import {
  to = module.dns.aws_acm_certificate.ssl_certificate
  id = "arn:aws:acm:us-east-1:966337238076:certificate/fb067fc4-a154-4884-adfa-059bb686ab7b" # the ID of the resource in the source platform
}

locals {
  domain_validation_options = [
    {
      domain_name           = "*.timmytandian.com"
      resource_record_name  = "_ee90e2aad96f9507293adb9a1eff9b7c.timmytandian.com."
      resource_record_type  = "CNAME"
      resource_record_value = "_4b88be6c3da74680123391e24e6039b8.gnvqnzwrct.acm-validations.aws."
    },
    {
      domain_name           = "timmytandian.com"
      resource_record_name  = "_ee90e2aad96f9507293adb9a1eff9b7c.timmytandian.com."
      resource_record_type  = "CNAME"
      resource_record_value = "_4b88be6c3da74680123391e24e6039b8.gnvqnzwrct.acm-validations.aws."
    }
  ]
}

import {
  
  for_each = {
    for dvo in local.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  to = module.dns.aws_route53_record.ssl_certificate[each.key]
  id = format("%s_%s_%s", "Z09296125XCW1X0VJESI", each.value.name, each.value.type)
}

###################################################
# DNS record for the website
###################################################
import {
  to = module.dns.aws_route53_record.main
  id = format("%s_%s_%s", "Z09296125XCW1X0VJESI", "timmytandian.com", "A")
}

import {
  to = module.dns.aws_route53_record.www
  id = format("%s_%s_%s", "Z09296125XCW1X0VJESI", "www.timmytandian.com", "A")
}