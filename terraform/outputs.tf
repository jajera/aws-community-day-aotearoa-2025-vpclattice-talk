output "vpc_lattice_service_dns_names" {
  description = "VPC Lattice service DNS names"
  value = {
    api      = module.setup_vpc_lattice.vpc_lattice_service_dns_names.api
    products = module.setup_vpc_lattice.vpc_lattice_service_dns_names.products
  }
}

output "custom_domains" {
  description = "Custom domains for the services"
  value = {
    api      = "api.${local.route53_zone_name}"
    products = "products.${local.route53_zone_name}"
  }
}

output "web_server" {
  description = "Web server information"
  value = {
    instance_id   = module.setup_vpc_lattice_demo_web_server.instance_id
    private_ip    = module.setup_vpc_lattice_demo_web_server.private_ip
    public_ip     = module.setup_vpc_lattice_demo_web_server.public_ip
    web_url_http  = "http://${module.setup_vpc_lattice_demo_web_server.public_ip}"
    web_url_https = "https://${module.setup_vpc_lattice_demo_web_server.public_ip}"
  }
}

output "test_commands" {
  description = "Commands to test the services"
  value = {
    # API Service (Path-based routing)
    api_orders        = "curl -s api.${local.route53_zone_name}/orders | jq ."
    api_payments      = "curl -s api.${local.route53_zone_name}/payments | jq ."
    api_inventory     = "curl -s api.${local.route53_zone_name}/inventory | jq ."
    api_analytics     = "curl -s api.${local.route53_zone_name}/analytics | jq ."
    api_notifications = "curl -s api.${local.route53_zone_name}/notifications | jq ."
    api_health        = "curl -s api.${local.route53_zone_name}/health | jq ."

    # Products Service (Weighted routing)
    products_service = "curl -s products.${local.route53_zone_name} | jq ."

    # Web Interface
    web_interface = "https://${module.setup_vpc_lattice_demo_web_server.public_ip}"
  }
}

output "target_group_weights" {
  description = "Weight distribution for target groups"
  value = {
    products_v1 = "50%"
    products_v2 = "50%"
  }
}

output "routing_info" {
  description = "Routing configuration information"
  value = {
    api_service = {
      type = "Path-based routing"
      paths = {
        "/orders"        = "Lambda orders service"
        "/payments"      = "Lambda payments service"
        "/inventory"     = "Lambda inventory service"
        "/analytics"     = "ECS Fargate analytics service"
        "/notifications" = "EC2 notifications service"
        "/health"        = "EC2 health service"
        "default"        = "Lambda notfound service"
      }
    }
    products_service = {
      type = "Weighted routing"
      distribution = {
        "products-v1" = "50%"
        "products-v2" = "50%"
      }
    }
  }
}
