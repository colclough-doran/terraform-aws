module "vpc_sandbox" {
  source = "../../modules/vpc/"

  vpc_name = var.vpc_name
  aws_region = var.aws_region
  environment = var.environment

  vpc_cidr_block = ""
  subnet_cidr_block = ""  
  
  vpc_subnet_azs = ""

  public_subnet_required = true
}