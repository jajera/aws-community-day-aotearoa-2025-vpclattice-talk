output "instance_id" {
  description = "The ID of the EC2 web server instance"
  value       = module.ec2_web_server.instance_id
}

output "private_ip" {
  description = "The private IP address of the EC2 web server instance"
  value       = module.ec2_web_server.private_ip
}

output "public_ip" {
  description = "The public IP address of the EC2 web server instance"
  value       = module.ec2_web_server.public_ip
}
