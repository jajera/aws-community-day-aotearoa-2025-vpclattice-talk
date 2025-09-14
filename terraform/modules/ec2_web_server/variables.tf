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

variable "ec2_client_public_subnet_ids" {
  type        = list(string)
  description = "The IDs of the public subnets for the client VPC"
}
