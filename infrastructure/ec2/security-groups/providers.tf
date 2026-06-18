provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region

  default_tags {
    tags = {
      "Service"       = local.service
      "Terraform-URL" = local.terraform_url
    }
  }
}