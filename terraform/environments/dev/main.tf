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

module "static_web" {
  source                            = "../../modules/static_web"
  website_bucket_name               = "timmytandian.com"
  website_resource_source_directory = "../../../src/"
  env                               = local.env
}

module "cdn" {
  source                            = "../../modules/cdn"
  bucket_regional_domain_name       = module.static_web.main_static_website_regional_domain_name
  website_bucket_name               = module.static_web.main_static_website_name
  main_website_endpoint             = module.static_web.main_static_website_endpoint
  main_website_bucket_arn           = module.static_web.main_static_website_bucket_arn
  main_website_bucket_id            = module.static_web.main_static_website_bucket_id
  referer_custom_header             = "aBrAk4D4bR4"
  env                               = local.env
}
