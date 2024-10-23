variable "aws_region" {
  type        = string
  description = "AWS region to use for resource."
  default     = "us-east-1"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DMS hostnames to use for resources."
  default     = true
}

variable "vpc_cidr_block" {
  type        = string
  description = "Base CIDR block for VPC."
  default     = "10.0.0.0/16"
}

variable "vpc_public_subnets_cidr_block" {
  type        = list(string)
  description = "CIDR block for public subnets in VPC."
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Map a public IP Address for Subnet 1 instances."
  default     = true
}

variable "instance_type" {
  type        = string
  description = "Type for EC2 instance."
  default     = "t2.micro"
}

variable "company" {
  type        = string
  description = "Company name for resource tagging."
  default     = "Globomantics"
}

variable "project" {
  type        = string
  description = "Project name for resource tagging."
}


variable "billing_code" {
  type        = string
  description = "Billing code for resource  tagging."
}