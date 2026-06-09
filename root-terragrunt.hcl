# Data

generate "data" {
  path = "data.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
  data "aws_caller_identity" "current" {}
  EOF
}

# Locals

generate "locals" {
  path      = "locals.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
locals {
  service = "${replace(path_relative_to_include(), "\\", "/")}"
  terraform_url = "https://github.com/colclough-doran/terraform-aws/${replace(path_relative_to_include(), "\\", "/")}"
}
EOF
}

# Providers

generate "providers" {
  path      = "providers.tf"
  if_exists = "overwrite"
  contents  = <<EOF
    provider "aws" {
    region = "eu-west-1"
    profile = "sandbox"

    default_tags {
    tags = {
      "Service" = local.service
      "Terraform-URL" = local.terraform_url
    }
  }
}
EOF
}

# State

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "s3" {
    bucket  = "cd-tfstate-sandbox"
    key     = "${replace(path_relative_to_include(), "\\", "/")}/terraform.tfstate"
    region  = "eu-west-1"
    profile = "sandbox"
  }
}
EOF
}

# Variables

generate "variables" {
  path      = "variables.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
  variable "aws_profile" {}
  variable "aws_region" {}
  variable "environment" {}
EOF
}