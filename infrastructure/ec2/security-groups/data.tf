# https://github.com/colclough-doran/terraform-aws/infrastructure/vpc
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = var.state_bucket_name
    key     = "vpc/${var.state_file_name}"
    region  = var.aws_region
    profile = var.aws_profile
  }
}