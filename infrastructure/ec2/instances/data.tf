data "aws_ami" "ubuntu_server_latest" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-resolute-26.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

## Remote states

# https://github.com/colclough-doran/terraform-aws/infrastructure/iam/roles
data "terraform_remote_state" "iam_roles" {
  backend = "s3"
  config = {
    bucket  = var.state_bucket_name
    key     = "iam/roles/${var.state_file_name}"
    region  = var.aws_region
    profile = var.aws_profile
  }
}

# https://github.com/colclough-doran/terraform-aws/infrastructure/ec2/key-pairs
data "terraform_remote_state" "key_pairs" {
  backend = "s3"
  config = {
    bucket  = var.state_bucket_name
    key     = "ec2/key-pairs/${var.state_file_name}"
    region  = var.aws_region
    profile = var.aws_profile
  }
}

# https://github.com/colclough-doran/terraform-aws/infrastructure/ec2/security-groups
data "terraform_remote_state" "security_groups" {
  backend = "s3"
  config = {
    bucket  = var.state_bucket_name
    key     = "ec2/security-groups/${var.state_file_name}"
    region  = var.aws_region
    profile = var.aws_profile
  }
}

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