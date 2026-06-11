# https://github.com/colclough-doran/terraform-aws/infrastructure/vpc
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = "cd-tfstate-sandbox"
    key     = "vpc/terraform.tfstate"
    region  = "eu-west-1"
    profile = "sandbox"
  }
}