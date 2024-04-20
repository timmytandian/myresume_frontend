locals {
  env = "dev"
}

provider "aws" {
  region = "ap-northeast-1"
  
  default_tags {
    tags = {
      environment = local.env
      project = "myresume_frontend"
      managedBy = "terraform"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias = "us-east-1"

  default_tags {
    tags = {
      environment = local.env
      project = "myresume_frontend"
      managedBy = "terraform"
    }
  }
}

module "static_web" {
  source                            = "../../modules/static_web"
  website_bucket_name               = "timmytandian.com"
  website_resource_source_directory = "../../../src/"
  referer_custom_header             = var.secret_referer_custom_header
  env                               = local.env
}

module "cdn" {
  source                            = "../../modules/cdn"
  bucket_regional_domain_name       = module.static_web.main_static_website_regional_domain_name
  website_bucket_name_main          = module.static_web.main_static_website_name
  website_bucket_name_www           = module.static_web.www_subdomain_static_website_name
  main_website_endpoint             = module.static_web.main_static_website_endpoint
  referer_custom_header             = var.secret_referer_custom_header
  certificate_arn                   = module.dns.certificate_arn
  env                               = local.env
}

module "dns" {
  source                            = "../../modules/dns"
  hosted_zone_name                  = "timmytandian.com"
  main_domain                       = module.static_web.main_static_website_name
  www_domain                        = module.static_web.www_subdomain_static_website_name
  cdn_hosted_zone_id                = module.cdn.cdn_hosted_zone_id
  cdn_domain_name                   = module.cdn.cdn_domain_name
  env                               = local.env

  providers = {
    aws = aws.us-east-1
  }
}