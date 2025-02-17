output "app_vpc_id" {
  description = "The ID of the app VPC."
  value       = alicloud_vpc.app.id
}

output "security_vpc_id" {
  description = "The ID of the security VPC."
  value       = alicloud_vpc.security.id
}

output "app_vswitch_ids" {
  description = "The IDs of the app VSwitches."
  value       = [for vswitch in alicloud_vswitch.app : vswitch.id]
}

output "security_vswitch_ids" {
  description = "The IDs of the security VSwitches."
  value       = [for vswitch in alicloud_vswitch.security : vswitch.id]
}

output "gwlbe_vswitch_ids" {
  description = "The IDs of the gwlbe VSwitches."
  value       = [for vswitch in alicloud_vswitch.gwlbe : vswitch.id]
}

output "ipv4_gateway_app_id" {
  description = "The ID of the app IPv4 Gateway."
  value       = alicloud_vpc_ipv4_gateway.app.id
}

output "eip_address_id" {
  description = "The ID of the EIP address."
  value       = alicloud_eip_address.default.id
}

output "gwlb_load_balancer_id" {
  description = "The ID of the GWLB load balancer."
  value       = alicloud_gwlb_load_balancer.default.id
}

output "gwlb_server_group_id" {
  description = "The ID of the GWLB server group."
  value       = alicloud_gwlb_server_group.default.id
}

output "gwlb_listener_id" {
  description = "The ID of the GWLB listener."
  value       = alicloud_gwlb_listener.default.id
}

output "privatelink_vpc_endpoint_service_id" {
  description = "The ID of the VPC Endpoint Service."
  value       = alicloud_privatelink_vpc_endpoint_service.default.id
}

output "privatelink_vpc_endpoint_service_resource_ids" {
  description = "The IDs of the VPC Endpoints."
  value       = [for endpoint_service_resource in alicloud_privatelink_vpc_endpoint_service_resource.default : endpoint_service_resource.id]
}

output "privatelink_vpc_endpoint_ids" {
  description = "The IDs of the VPC Endpoints."
  value       = [for endpoint in alicloud_privatelink_vpc_endpoint.gwlbe : endpoint.id]
}

output "privatelink_vpc_endpoint_zone_ids" {
  description = "The IDs of the VPC Endpoints."
  value       = [for endpoint_zone in alicloud_privatelink_vpc_endpoint_zone.gwlbe : endpoint_zone.id]
}

output "route_table_ipv4_gateway_id" {
  description = "The ID of the IPv4 Gateway Route Table."
  value       = alicloud_route_table.ipv4_gateway_routetable.id
}

output "route_table_gwlbe_vpc_id" {
  description = "The ID of the GWLB VPC Route Table."
  value       = alicloud_route_table.gwlbe_vpc_routetable.id
}

output "route_table_app_vpc_ids" {
  description = "The IDs of the app VPC Route Tables."
  value       = [for route_table in alicloud_route_table.app_vpc_routetable : route_table.id]
}
