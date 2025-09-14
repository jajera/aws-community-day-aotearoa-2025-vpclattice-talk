############################################
# Jumphost
############################################

module "ec2_client" {
  source = "tfstack/jumphost/aws"

  name      = "${var.name_prefix}1-ec2-client"
  subnet_id = var.ec2_client_private_subnet_ids[0] # create ec2 in the first private subnet
  vpc_id    = var.vpc_ids["client"]                # vpc id of the client VPC from the VPC module

  create_security_group  = false                                     # we handle the security group in the VPC module
  vpc_security_group_ids = [var.security_group_ids["ec2_client_sg"]] # security group id of the EC2 client from the VPC module
  allowed_cidr_blocks    = var.ec2_client_allowed_cidr_blocks        # cidr blocks allowed to access the EC2 client
  assign_eip             = false                                     # we don't need an EIP for the EC2 client
  enable_ssm             = true                                      # allow us to connect to the EC2 client using SSM

  # install the tools we need for the ec2 client
  user_data_extra = <<-EOT
    hostname ${var.name_prefix}1-ec2-client
    yum install -y mtr nc jq
  EOT

  tags = {
    Name = "${var.name_prefix}1-ec2-client"
  }
}

############################################
# Notification Service
############################################

module "ec2_notifications_service" {
  source = "tfstack/ec2-server/aws"

  name      = "${var.name_prefix}3-notifications-service"
  subnet_id = var.app_2_private_subnet_ids[1] # create ec2 in the second private subnet
  vpc_id    = var.vpc_ids["app_2"]            # vpc id of the app 2 VPC from the VPC module

  create_security_group  = false # we handle the security group in the VPC module
  vpc_security_group_ids = [var.security_group_ids["notifications_service_sg"]]

  instance_type    = "t3.micro"
  assign_public_ip = false # we don't need a public IP for the EC2 notifications service
  enable_ssm       = true  # allows us to connect to the EC2 notifications service using SSM when we need to troubleshoot

  # setup the nginx web server to demonstrate the notifications service
  user_data = <<-EOT
#!/bin/bash
exec > >(tee /var/log/user-data.log) 2>&1

echo "Starting notifications service setup..."

# Update system
if command -v dnf >/dev/null 2>&1; then
  dnf -y update
else
  yum -y update
fi

# Install nginx using amazon-linux-extras
amazon-linux-extras install nginx1 -y

# Configure nginx
cat > /etc/nginx/conf.d/default.conf << 'NGINX'
server {
    listen 80;
    location / {
        add_header Content-Type application/json;
        return 200 '{"api_version":"1.0","service":"notifications-service","message":"Notifications Service (EC2)","notifications":[{"id":"N001","type":"email","status":"sent","recipient":"john@example.com","subject":"Order Confirmation"},{"id":"N002","type":"sms","status":"pending","recipient":"+1234567890","message":"Payment processed"},{"id":"N003","type":"push","status":"delivered","recipient":"user123","title":"New product available"}],"_demo_info":{"service_type":"Notifications Service (EC2)","target_url":"http://api.example.local/notifications","routing_method":"Path-based"}}';
    }
    location /health {
        add_header Content-Type application/json;
        return 200 '{"status":"healthy","service":"notifications-service"}';
    }
}
NGINX

# Start and enable nginx
systemctl start nginx
systemctl enable nginx

echo "Notifications service setup completed successfully!"
EOT

  instance_tags = {
    Service = "notifications"
    Domain  = "communication"
  }
}
