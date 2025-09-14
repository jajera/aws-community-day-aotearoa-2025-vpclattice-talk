module "vpc_1" {
  source = "cloudbuildlab/vpc/aws"

  vpc_name           = "${var.name_prefix}1"
  vpc_cidr           = "10.0.0.0/16"
  availability_zones = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]

  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  # Enable Internet Gateway & NAT Gateway
  create_igw       = true
  nat_gateway_type = "single"

  tags = {
    Environment = "dev"
    VPC         = "client"
  }
}

module "vpc_2" {
  source = "cloudbuildlab/vpc/aws"

  vpc_name           = "${var.name_prefix}2"
  vpc_cidr           = "10.1.0.0/16"
  availability_zones = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]

  public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  private_subnet_cidrs = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]

  # Enable Internet Gateway & NAT Gateway
  create_igw       = true
  nat_gateway_type = "single"

  tags = {
    Environment = "dev"
    VPC         = "app-1"
  }
}

module "vpc_3" {
  source = "cloudbuildlab/vpc/aws"

  vpc_name           = "${var.name_prefix}3"
  vpc_cidr           = "10.2.0.0/16"
  availability_zones = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]

  public_subnet_cidrs  = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
  private_subnet_cidrs = ["10.2.101.0/24", "10.2.102.0/24", "10.2.103.0/24"]

  # Enable Internet Gateway & NAT Gateway
  create_igw       = true
  nat_gateway_type = "single"

  tags = {
    Environment = "dev"
    VPC         = "app-2"
  }
}

# Get current user's public IP
data "http" "my_public_ip" {
  url = "https://checkip.amazonaws.com/"
}

resource "aws_security_group" "ec2_client_sg" {
  name        = "${var.name_prefix}1-ec2-client-sg"
  description = "Security group for EC2 client in VPC 1"
  vpc_id      = module.vpc_1.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}1-ec2-client-sg"
  }
}

resource "aws_security_group" "lambda_sg" {
  name        = "${var.name_prefix}2-lambda-sg"
  description = "Security group for Lambda in VPC 2"
  vpc_id      = module.vpc_2.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = module.vpc_2.private_subnet_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}2-lambda-sg"
  }
}

resource "aws_security_group" "vpc_lattice_2_sg" {
  name        = "${var.name_prefix}2-vpc-lattice-sg"
  description = "Security group for VPC Lattice in VPC 2"
  vpc_id      = module.vpc_2.vpc_id

  ingress {
    description = "Allow HTTP port 80 access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [module.vpc_2.vpc_cidr, local.vpc_lattice_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}2-vpc-lattice-sg"
  }
}

resource "aws_security_group" "web_server_sg" {
  name        = "${var.name_prefix}1-web-server-sg"
  description = "Security group for EC2 web server in VPC 1"
  vpc_id      = module.vpc_1.vpc_id

  ingress {
    description = "Allow HTTP port 80 access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS port 443 access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}1-web-server-sg"
  }
}

resource "aws_security_group" "fargate_sg" {
  name        = "${var.name_prefix}3-fargate-sg"
  description = "Security group for Fargate in VPC 3"
  vpc_id      = module.vpc_3.vpc_id

  ingress {
    description = "Allow HTTP port 8000 access"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = [module.vpc_3.vpc_cidr, local.vpc_lattice_cidr]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}3-fargate-sg"
  }
}

resource "aws_security_group" "notifications_service_sg" {
  name        = "${var.name_prefix}3-notifications-service-sg"
  description = "Security group for Notifications Service in VPC 3"
  vpc_id      = module.vpc_3.vpc_id

  ingress {
    description = "Allow HTTP port 80 access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [module.vpc_3.vpc_cidr, local.vpc_lattice_cidr]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}3-notifications-service-sg"
  }
}

resource "aws_security_group" "vpc_lattice_3_sg" {
  name        = "${var.name_prefix}3-vpc-lattice-sg"
  description = "Security group for VPC Lattice in VPC 3"
  vpc_id      = module.vpc_3.vpc_id

  ingress {
    description = "Allow HTTP port 80 access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [module.vpc_3.vpc_cidr, local.vpc_lattice_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}3-vpc-lattice-sg"
  }
}
