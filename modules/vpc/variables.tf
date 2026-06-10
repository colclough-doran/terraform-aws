variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "The environment the VPC is created in"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "production"], lower(var.environment))
    error_message = "Environment must be dev, staging, or production."
  }
}

variable "ngw_mode" {
  description = "The availability mode for NAT gateway"
  type        = string
  default     = "regional"
}

variable "igw_required" {
  description = "Is resrouce required?"
  type        = bool
  default     = false
}

variable "ngw_required" {
  description = "Is resrouce required?"
  type        = bool
  default     = false
}

variable "public_route_table_required" {
  description = "Is resrouce required?"
  type        = bool
  default     = false
}

variable "private_route_table_required" {
  description = "Is resrouce required?"
  type        = bool
  default     = false
}

variable "project_scope" {
  description = "The proejct name or scope"
  type        = string
}

variable "subnet_cidr_block" {
  description = "The CIDR block the subnets can choose from"
  type        = map(string)
}

variable "vpc_cidr_block" {
  description = "The CIDR block used by the VPC"
  type        = string
}

variable "vpc_subnet_azs" {
  description = "The availability zones useds by the subnets"
  type        = list(string)
}