# PRIVATE SUBNETS
resource "aws_subnet" "private" {
  # If false, set count to 0 and skip creation
  count = var.private_subnet_required == true ? 1 : 0

  for_each = toset(var.vpc_subnet_azs)

  availability_zone = each.key
  region            = var.aws_region
  cidr_block        = lookup(var.subnet_cidr_block, "private-subnet-${each.key}")
  vpc_id            = aws_vpc.this.id

  tags = {
    Name = "private-subnet-${each.key}"
  }
}

# PUBLIC SUBNETS
resource "aws_subnet" "public" {
  # If false, set count to 0 and skip creation
  count = var.public_subnet_required == true ? 1 : 0

  for_each = toset(var.vpc_subnet_azs)

  availability_zone = each.key
  region            = var.aws_region
  cidr_block        = lookup(var.subnet_cidr_block, "public-subnet-${each.key}")
  vpc_id            = aws_vpc.this.id

  tags = {
    Name = "public-subnet-${each.key}"
  }
} 