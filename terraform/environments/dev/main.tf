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