# Internet  Gateway
resource "aws_internet_gateway" "this" {
  # If false, set count to 0 and skip creation
  count = var.igw_required == true ? 1 : 0

  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "this" {
  # If false, set count to 0 and skip creation
  count = var.ngw_required == true ? 1 : 0

  vpc_id            = aws_vpc.this.id
  availability_mode = var.ngw_mode

  tags = {
    Name = "${var.vpc_name}-ngw"
  }

  depends_on = [
    aws_internet_gateway.this
  ]
}