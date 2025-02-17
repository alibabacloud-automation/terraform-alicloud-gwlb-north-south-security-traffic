output "app_vpc_id" {
  description = "The ID of the app VPC."
  value       = module.complete.app_vpc_id
}

output "security_vpc_id" {
  description = "The ID of the security VPC."
  value       = module.complete.security_vpc_id
}

output "app_vswitch_ids" {
  description = "The IDs of the app VSwitches."
  value       = module.complete.app_vswitch_ids
}

output "security_vswitch_ids" {
  description = "The IDs of the security VSwitches."
  value       = module.complete.security_vswitch_ids
}

output "gwlbe_vswitch_ids" {
  description = "The IDs of the gwlbe VSwitches."
  value       = module.complete.gwlbe_vswitch_ids
}

output "ipv4_gateway_app_id" {
  description = "The ID of the app IPv4 Gateway."
  value       = module.complete.ipv4_gateway_app_id
}

output "eip_address_id" {
  description = "The ID of the EIP address."
  value       = module.complete.eip_address_id
}

output "gwlb_load_balancer_id" {
  description = "The ID of the GWLB load balancer."
  value       = module.complete.gwlb_load_balancer_id
}

output "gwlb_server_group_id" {
  description = "The ID of the GWLB server group."
  value       = module.complete.gwlb_server_group_id
}

output "gwlb_listener_id" {
  description = "The ID of the GWLB listener."
  value       = module.complete.gwlb_listener_id
}

output "privatelink_vpc_endpoint_service_id" {
  description = "The ID of the VPC Endpoint Service."
  value       = module.complete.privatelink_vpc_endpoint_service_id
}

output "privatelink_vpc_endpoint_service_resource_ids" {
  description = "The IDs of the VPC Endpoints."
  value       = module.complete.privatelink_vpc_endpoint_service_resource_ids
}

output "privatelink_vpc_endpoint_ids" {
  description = "The IDs of the VPC Endpoints."
  value       = module.complete.privatelink_vpc_endpoint_ids
}

output "privatelink_vpc_endpoint_zone_ids" {
  description = "The IDs of the VPC Endpoints."
  value       = module.complete.privatelink_vpc_endpoint_zone_ids
}

output "route_table_ipv4_gateway_id" {
  description = "The ID of the IPv4 Gateway Route Table."
  value       = module.complete.route_table_ipv4_gateway_id
}

output "route_table_gwlbe_vpc_id" {
  description = "The ID of the GWLB VPC Route Table."
  value       = module.complete.route_table_gwlbe_vpc_id
}

output "route_table_app_vpc_ids" {
  description = "The IDs of the app VPC Route Tables."
  value       = module.complete.route_table_app_vpc_ids
}
