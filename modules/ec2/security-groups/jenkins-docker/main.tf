resource "aws_security_group" "this" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = var.vpc_id

  tags = {
    Name = var.security_group_name
  }
}

# Egress Rules

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Allow all outbound traffic"
}

resource "aws_vpc_security_group_egress_rule" "allow_meta" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "169.254.169.254/32"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  description       = "Allow AWS meta"
}

# Ingress Rules

resource "aws_vpc_security_group_ingress_rule" "allow_jenkins_web" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = var.vpc_cidr_block
  ip_protocol       = "tcp"
  from_port         = 8080
  to_port           = 8080
  description       = "Jenkins web UI"
} 