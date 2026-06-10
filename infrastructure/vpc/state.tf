terraform {
  backend "s3" {
    bucket  = "cd-tfstate-sandbox"
    key     = "vpc/terraform.tfstate"
    region  = "eu-west-1"
    profile = "sandbox"
  }
}