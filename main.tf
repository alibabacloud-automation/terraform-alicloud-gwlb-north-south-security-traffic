# VPC
resource "alicloud_vpc" "app" {
  vpc_name   = var.vpc_app.vpc_name
  cidr_block = var.vpc_app.cidr_block
}

resource "alicloud_vpc" "security" {
  vpc_name   = var.vpc_security.vpc_name
  cidr_block = var.vpc_security.cidr_block
}

# VSwitch
resource "alicloud_vswitch" "app" {
  for_each     = { for i, v in var.zone_ids : i => v }
  vpc_id       = alicloud_vpc.app.id
  zone_id      = each.value
  vswitch_name = "${var.vswitches.app.vswitch_name_prefix}-${each.key}"
  cidr_block   = var.vswitches.app.cidr_block[each.key]
}

resource "alicloud_vswitch" "gwlbe" {
  for_each     = { for i, v in var.zone_ids : i => v }
  vpc_id       = alicloud_vpc.app.id
  zone_id      = each.value
  vswitch_name = "${var.vswitches.gwlbe.vswitch_name_prefix}-${each.key}"
  cidr_block   = var.vswitches.gwlbe.cidr_block[each.key]
}

resource "alicloud_vswitch" "security" {
  for_each     = { for i, v in var.zone_ids : i => v }
  vpc_id       = alicloud_vpc.security.id
  zone_id      = each.value
  vswitch_name = "${var.vswitches.security.vswitch_name_prefix}-${each.key}"
  cidr_block   = var.vswitches.security.cidr_block[each.key]
}

# Gateway
resource "alicloud_vpc_ipv4_gateway" "app" {
  vpc_id                   = alicloud_vpc.app.id
  ipv4_gateway_name        = var.ipv4_gateway.name
  ipv4_gateway_description = var.ipv4_gateway.description
  enabled                  = var.ipv4_gateway.enabled
}

resource "alicloud_eip_address" "default" {
  isp                  = var.eip_address.isp
  bandwidth            = var.eip_address.bandwidth
  internet_charge_type = var.eip_address.internet_charge_type
}

# GWLB
resource "alicloud_gwlb_load_balancer" "default" {
  vpc_id = alicloud_vpc.security.id
  dynamic "zone_mappings" {
    for_each = alicloud_vswitch.security
    content {
      vswitch_id = zone_mappings.value.id
      zone_id    = zone_mappings.value.zone_id
    }
  }
  address_ip_version = "Ipv4"
}

resource "alicloud_gwlb_server_group" "default" {
  vpc_id    = alicloud_vpc.security.id
  scheduler = var.gwlb_server_group.scheduler
  health_check_config {
    health_check_protocol        = var.gwlb_server_group.health_check_config.health_check_protocol
    health_check_connect_port    = var.gwlb_server_group.health_check_config.health_check_connect_port
    health_check_connect_timeout = var.gwlb_server_group.health_check_config.health_check_connect_timeout
    health_check_domain          = var.gwlb_server_group.health_check_config.health_check_domain
    health_check_enabled         = var.gwlb_server_group.health_check_config.health_check_enabled
    health_check_http_code       = var.gwlb_server_group.health_check_config.health_check_http_code
    health_check_interval        = var.gwlb_server_group.health_check_config.health_check_interval
    health_check_path            = var.gwlb_server_group.health_check_config.health_check_path
    healthy_threshold            = var.gwlb_server_group.health_check_config.healthy_threshold
    unhealthy_threshold          = var.gwlb_server_group.health_check_config.unhealthy_threshold
  }
  protocol          = var.gwlb_server_group.protocol
  server_group_type = var.gwlb_server_group.server_group_type
  connection_drain_config {
    connection_drain_enabled = var.gwlb_server_group.connection_drain_config.connection_drain_enabled
    connection_drain_timeout = var.gwlb_server_group.connection_drain_config.connection_drain_timeout
  }
  dynamic "servers" {
    for_each = var.gwlb_server_group.servers
    content {
      server_id   = servers.value.server_id
      server_ip   = servers.value.server_ip
      server_type = servers.value.server_type
    }
  }
  server_group_name = var.gwlb_server_group.server_group_name
}


resource "alicloud_gwlb_listener" "default" {
  listener_description = var.gwlb_listener.listener_description
  server_group_id      = alicloud_gwlb_server_group.default.id
  load_balancer_id     = alicloud_gwlb_load_balancer.default.id
}

# private link
resource "alicloud_privatelink_vpc_endpoint_service" "default" {
  service_description    = "gwlb"
  auto_accept_connection = true
  service_resource_type  = "gwlb"
}

resource "alicloud_privatelink_vpc_endpoint_service_resource" "default" {
  for_each      = { for i, v in var.zone_ids : i => v }
  service_id    = alicloud_privatelink_vpc_endpoint_service.default.id
  resource_id   = alicloud_gwlb_load_balancer.default.id
  resource_type = "gwlb"
  zone_id       = each.value
}

resource "alicloud_privatelink_vpc_endpoint" "gwlbe" {
  for_each = { for i, v in var.zone_ids : i => v }

  endpoint_type = "GatewayLoadBalancer"
  vpc_id        = alicloud_vpc.app.id
  service_id    = alicloud_privatelink_vpc_endpoint_service.default.id
}
resource "alicloud_privatelink_vpc_endpoint_zone" "gwlbe" {
  for_each = { for i, v in var.zone_ids : i => v }

  endpoint_id = alicloud_privatelink_vpc_endpoint.gwlbe[each.key].id
  vswitch_id  = alicloud_vswitch.gwlbe[each.key].id
  zone_id     = each.value
}

# ipv4_gateway route table
resource "alicloud_route_table" "ipv4_gateway_routetable" {
  vpc_id           = alicloud_vpc.app.id
  route_table_name = var.ipv4_gateway_routetable_name
  associate_type   = "Gateway"
}
resource "alicloud_vpc_gateway_route_table_attachment" "ipv4_gateway_routetable_attachment" {
  ipv4_gateway_id = alicloud_vpc_ipv4_gateway.app.id
  route_table_id  = alicloud_route_table.ipv4_gateway_routetable.id
}

# app VPC route table
resource "alicloud_route_table" "gwlbe_vpc_routetable" {
  vpc_id           = alicloud_vpc.app.id
  route_table_name = var.gwlbe_vpc_routetable_name
}
resource "alicloud_route_table_attachment" "gwlbe_vpc_routetable" {
  for_each = { for i, v in var.zone_ids : i => v }

  vswitch_id     = alicloud_vswitch.gwlbe[each.key].id
  route_table_id = alicloud_route_table.gwlbe_vpc_routetable.id
}

resource "alicloud_route_table" "app_vpc_routetable" {
  for_each = { for i, v in var.zone_ids : i => v }

  vpc_id           = alicloud_vpc.app.id
  route_table_name = "${var.app_vpc_routetable_name}-${each.key}"
}
resource "alicloud_route_table_attachment" "app_vpc_routetable" {
  for_each = { for i, v in var.zone_ids : i => v }

  vswitch_id     = alicloud_vswitch.app[each.key].id
  route_table_id = alicloud_route_table.app_vpc_routetable[each.key].id
}

resource "alicloud_route_entry" "gwlbe_to_ipv4_gateway" {
  route_table_id        = alicloud_route_table.gwlbe_vpc_routetable.id
  destination_cidrblock = "0.0.0.0/0"
  nexthop_type          = "Ipv4Gateway"
  nexthop_id            = alicloud_vpc_ipv4_gateway.app.id
}

resource "alicloud_route_entry" "app_to_gwlbe" {
  for_each = { for i, v in var.zone_ids : i => v }

  route_table_id        = alicloud_route_table.app_vpc_routetable[each.key].id
  destination_cidrblock = "0.0.0.0/0"
  nexthop_type          = "GatewayLoadBalancerEndpoint"
  nexthop_id            = alicloud_privatelink_vpc_endpoint_zone.gwlbe[each.key].endpoint_id
}
