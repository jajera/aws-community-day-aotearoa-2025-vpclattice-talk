output "vpc_lattice_service_dns_names" {
  description = "VPC Lattice service DNS entries names"
  value = {
    api      = module.vpc_lattice.service_dns_entries["api"].domain_name
    products = module.vpc_lattice.service_dns_entries["products"].domain_name
  }
}
