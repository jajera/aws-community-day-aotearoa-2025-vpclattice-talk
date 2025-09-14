variable "name_prefix" {
  type        = string
  description = "The prefix name of the resources"
}

variable "name_suffix" {
  type        = string
  description = "The random generated suffix for the resources"
}

variable "vpc_ids" {
  type        = map(string)
  description = "The IDs of the VPCs"
}

variable "security_group_ids" {
  type        = map(string)
  description = "The IDs of the security groups"
}

variable "app_2_private_subnet_cidrs" {
  type        = list(string)
  description = "The CIDR blocks of the private subnets for the app 2 VPC"
}

variable "app_2_private_subnet_ids" {
  type        = list(string)
  description = "The IDs of the private subnets for the app 2 VPC"
}

variable "app_2_public_subnet_cidrs" {
  type        = list(string)
  description = "The CIDR blocks of the public subnets for the app 2 VPC"
}

variable "app_2_public_subnet_ids" {
  type        = list(string)
  description = "The IDs of the public subnets for the app 2 VPC"
}
