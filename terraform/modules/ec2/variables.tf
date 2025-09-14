variable "name_prefix" {
  type        = string
  description = "The prefix name of the resources"
}

variable "vpc_ids" {
  type        = map(string)
  description = "The IDs of the VPCs"
}

variable "security_group_ids" {
  type        = map(string)
  description = "The IDs of the security groups"
}

variable "ec2_client_allowed_cidr_blocks" {
  type        = list(string)
  description = "The CIDR blocks allowed to access the EC2 client"
}

variable "ec2_client_private_subnet_ids" {
  type        = list(string)
  description = "The IDs of the private subnets for the client VPC"
}

variable "app_2_private_subnet_ids" {
  type        = list(string)
  description = "The IDs of the private subnets for the app 2 VPC"
}
