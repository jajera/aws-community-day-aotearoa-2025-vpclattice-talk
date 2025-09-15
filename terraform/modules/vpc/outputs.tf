output "vpc_ids" {
  description = "Map of all VPC IDs"
  value = {
    client = module.vpc_1.vpc_id
    app_1  = module.vpc_2.vpc_id
    app_2  = module.vpc_3.vpc_id
  }
}

output "security_group_ids" {
  description = "Map of all security group IDs"
  value = {
    ec2_client_sg            = aws_security_group.ec2_client_sg.id
    fargate_sg               = aws_security_group.fargate_sg.id
    lambda_sg                = aws_security_group.lambda_sg.id
    notifications_service_sg = aws_security_group.notifications_service_sg.id
    health_service_sg        = aws_security_group.health_service_sg.id
    vpc_lattice_2_sg         = aws_security_group.vpc_lattice_2_sg.id
    vpc_lattice_3_sg         = aws_security_group.vpc_lattice_3_sg.id
    web_server_sg            = aws_security_group.web_server_sg.id
  }
}

output "private_subnet_cidrs" {
  description = "Map of all private subnet CIDR blocks grouped by VPC"
  value = {
    client = module.vpc_1.private_subnet_cidrs
    app1   = module.vpc_2.private_subnet_cidrs
    app2   = module.vpc_3.private_subnet_cidrs
  }
}

output "private_subnet_ids" {
  description = "Map of all private subnet IDs grouped by VPC"
  value = {
    client = module.vpc_1.private_subnet_ids
    app1   = module.vpc_2.private_subnet_ids
    app2   = module.vpc_3.private_subnet_ids
  }
}

output "public_subnet_cidrs" {
  description = "Map of all public subnet CIDR blocks grouped by VPC"
  value = {
    client = module.vpc_1.public_subnet_cidrs
    app1   = module.vpc_2.public_subnet_cidrs
    app2   = module.vpc_3.public_subnet_cidrs
  }
}

output "public_subnet_ids" {
  description = "Map of all public subnet IDs grouped by VPC"
  value = {
    client = module.vpc_1.public_subnet_ids
    app1   = module.vpc_2.public_subnet_ids
    app2   = module.vpc_3.public_subnet_ids
  }
}

output "my_public_ip" {
  description = "Current user's public IP address"
  value       = trimspace(data.http.my_public_ip.response_body)
}
