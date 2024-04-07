terraform {
  backend "s3" {
    bucket         = "terraform-tfstate-cloudresume"
    key            = "frontend/dev/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-cloudresume-state-locking"
    encrypt        = true
  }
}