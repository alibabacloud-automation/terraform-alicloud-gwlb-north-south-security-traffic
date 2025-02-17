Terraform module to build a security check system for IPv4 traffic on Alibaba Cloud

terraform-alicloud-gwlb-north-south-security-traffic
======================================

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-gwlb-north-south-security-traffic/blob/main/README-CN.md)

To enhance business security and reliability, an enterprise wants to route IPv4 traffic over the Internet to NVAs for security checks before forwarding the traffic to application servers for processing.This topic describes how to configure a GWLB instance and GWLB endpoints to create a security check system for IPv4 traffic.  

> After the current Module has been deployed, you need to edit the system route entry for the app_vswitch segment in the VPC Console - IPv4 Gateway Routing Table to change its next hop type to Gateway SLB Endpoint.
>
> Reference Documents: [Use a GWLB instance to create a security check system for IPv4 traffic](https://www.alibabacloud.com/help/en/slb/gateway-based-load-balancing-gwlb/getting-started/gwlb-quickly-implements-load-balancing-for-ipv4-services#04456fafa3xaj)


Architecture Diagram:

![image](https://raw.githubusercontent.com/alibabacloud-automation/terraform-alicloud-gwlb-north-south-security-traffic/main/scripts/diagram.png)


## Usage

```hcl
provider "alicloud" {
  region = "cn-wulanchabu"
}

module "complete" {
  source = "alibabacloud-automation/gwlb-north-south-security-traffic/alicloud"

  vpc_security = {
    cidr_block = "172.16.0.0/16"
  }
  vpc_app = {
    cidr_block = "192.168.0.0/16"
  }
  zone_ids = ["cn-wulanchabu-b", "cn-wulanchabu-c"]
  vswitches = {
    app = {
      cidr_block = ["192.168.1.0/24", "192.168.2.0/24"]
    }
    gwlbe = {
      cidr_block = ["192.168.101.0/28", "192.168.102.0/28"]
    }
    security = {
      cidr_block = ["172.16.1.0/24", "172.16.2.0/24"]
    }
  }

  gwlb_server_group = {
    servers = [{
      server_id   = "172.16.1.100"
      server_ip   = "172.16.1.100"
      server_type = "Ip"
      }, {
      server_id   = "172.16.2.100"
      server_ip   = "172.16.2.100"
      server_type = "Ip"
    }]
  }
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-gwlb-north-south-security-traffic/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_eip_address.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/eip_address) | resource |
| [alicloud_gwlb_listener.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/gwlb_listener) | resource |
| [alicloud_gwlb_load_balancer.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/gwlb_load_balancer) | resource |
| [alicloud_gwlb_server_group.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/gwlb_server_group) | resource |
| [alicloud_privatelink_vpc_endpoint.gwlbe](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/privatelink_vpc_endpoint) | resource |
| [alicloud_privatelink_vpc_endpoint_service.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/privatelink_vpc_endpoint_service) | resource |
| [alicloud_privatelink_vpc_endpoint_service_resource.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/privatelink_vpc_endpoint_service_resource) | resource |
| [alicloud_privatelink_vpc_endpoint_zone.gwlbe](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/privatelink_vpc_endpoint_zone) | resource |
| [alicloud_route_entry.app_to_gwlbe](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_entry.gwlbe_to_ipv4_gateway](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/route_entry) | resource |
| [alicloud_route_table.app_vpc_routetable](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/route_table) | resource |
| [alicloud_route_table.gwlbe_vpc_routetable](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/route_table) | resource |
| [alicloud_route_table.ipv4_gateway_routetable](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/route_table) | resource |
| [alicloud_route_table_attachment.app_vpc_routetable](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/route_table_attachment) | resource |
| [alicloud_route_table_attachment.gwlbe_vpc_routetable](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/route_table_attachment) | resource |
| [alicloud_vpc.app](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc.security](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vpc_gateway_route_table_attachment.ipv4_gateway_routetable_attachment](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vpc_gateway_route_table_attachment) | resource |
| [alicloud_vpc_ipv4_gateway.app](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vpc_ipv4_gateway) | resource |
| [alicloud_vswitch.app](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.gwlbe](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_vswitch.security](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_vpc_routetable_name"></a> [app\_vpc\_routetable\_name](#input\_app\_vpc\_routetable\_name) | The name of the app VPC routing table. | `string` | `"app-vpc-routetable"` | no |
| <a name="input_eip_address"></a> [eip\_address](#input\_eip\_address) | The configuration of eip address. | <pre>object({<br>    isp                  = optional(string, "BGP")<br>    bandwidth            = optional(string, "2")<br>    internet_charge_type = optional(string, "PayByTraffic")<br>  })</pre> | `{}` | no |
| <a name="input_gwlb_listener"></a> [gwlb\_listener](#input\_gwlb\_listener) | Configuration for the GWLB listener. | <pre>object({<br>    listener_description = optional(string, null)<br>  })</pre> | `{}` | no |
| <a name="input_gwlb_server_group"></a> [gwlb\_server\_group](#input\_gwlb\_server\_group) | Configuration for the GWLB server group. | <pre>object({<br>    scheduler = optional(string, "5TCH")<br>    health_check_config = optional(object({<br>      health_check_protocol        = optional(string, "TCP")<br>      health_check_connect_port    = optional(number, 80)<br>      health_check_connect_timeout = optional(number, 5)<br>      health_check_domain          = optional(string, null)<br>      health_check_enabled         = optional(bool, true)<br>      health_check_http_code       = optional(list(string), null)<br>      health_check_interval        = optional(number, 10)<br>      health_check_path            = optional(string, null)<br>      healthy_threshold            = optional(number, 2)<br>      unhealthy_threshold          = optional(number, 2)<br>    }), {})<br>    protocol          = optional(string, "GENEVE")<br>    server_group_type = optional(string, "Ip")<br>    connection_drain_config = optional(object({<br>      connection_drain_enabled = optional(bool, true)<br>      connection_drain_timeout = optional(number, 1)<br>    }), {})<br>    servers = optional(list(object({<br>      server_id   = string<br>      server_ip   = string<br>      server_type = string<br>    })), [])<br>    server_group_name = optional(string, null)<br>  })</pre> | `{}` | no |
| <a name="input_gwlbe_vpc_routetable_name"></a> [gwlbe\_vpc\_routetable\_name](#input\_gwlbe\_vpc\_routetable\_name) | The name of the GWLB VPC routing table. | `string` | `"gwlb-vpc-routetable"` | no |
| <a name="input_ipv4_gateway"></a> [ipv4\_gateway](#input\_ipv4\_gateway) | The configuration of ipv4 gateway. | <pre>object({<br>    name        = optional(string, "app")<br>    description = optional(string, null)<br>    enabled     = optional(bool, true)<br>  })</pre> | `{}` | no |
| <a name="input_ipv4_gateway_routetable_name"></a> [ipv4\_gateway\_routetable\_name](#input\_ipv4\_gateway\_routetable\_name) | The name of the IPv4 gateway routing table. | `string` | `"ipv4-gateway-routetable"` | no |
| <a name="input_vpc_app"></a> [vpc\_app](#input\_vpc\_app) | The configuration of app vpc. | <pre>object({<br>    vpc_name   = optional(string, "vpc-app")<br>    cidr_block = string<br>  })</pre> | n/a | yes |
| <a name="input_vpc_security"></a> [vpc\_security](#input\_vpc\_security) | The configuration of security vpc. | <pre>object({<br>    vpc_name   = optional(string, "vpc-security")<br>    cidr_block = string<br>  })</pre> | n/a | yes |
| <a name="input_vswitches"></a> [vswitches](#input\_vswitches) | The configuration of vswitches. | <pre>object({<br>    security = object({<br>      vswitch_name_prefix = optional(string, "vsw-security")<br>      cidr_block          = list(string)<br>    })<br>    gwlbe = object({<br>      vswitch_name_prefix = optional(string, "vsw-gwlb")<br>      cidr_block          = list(string)<br>    })<br>    app = object({<br>      vswitch_name_prefix = optional(string, "vsw-app")<br>      cidr_block          = list(string)<br>    })<br>  })</pre> | n/a | yes |
| <a name="input_zone_ids"></a> [zone\_ids](#input\_zone\_ids) | The zone ids of vswitches. The length of this list must be two. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_vpc_id"></a> [app\_vpc\_id](#output\_app\_vpc\_id) | The ID of the app VPC. |
| <a name="output_app_vswitch_ids"></a> [app\_vswitch\_ids](#output\_app\_vswitch\_ids) | The IDs of the app VSwitches. |
| <a name="output_eip_address_id"></a> [eip\_address\_id](#output\_eip\_address\_id) | The ID of the EIP address. |
| <a name="output_gwlb_listener_id"></a> [gwlb\_listener\_id](#output\_gwlb\_listener\_id) | The ID of the GWLB listener. |
| <a name="output_gwlb_load_balancer_id"></a> [gwlb\_load\_balancer\_id](#output\_gwlb\_load\_balancer\_id) | The ID of the GWLB load balancer. |
| <a name="output_gwlb_server_group_id"></a> [gwlb\_server\_group\_id](#output\_gwlb\_server\_group\_id) | The ID of the GWLB server group. |
| <a name="output_gwlbe_vswitch_ids"></a> [gwlbe\_vswitch\_ids](#output\_gwlbe\_vswitch\_ids) | The IDs of the gwlbe VSwitches. |
| <a name="output_ipv4_gateway_app_id"></a> [ipv4\_gateway\_app\_id](#output\_ipv4\_gateway\_app\_id) | The ID of the app IPv4 Gateway. |
| <a name="output_privatelink_vpc_endpoint_ids"></a> [privatelink\_vpc\_endpoint\_ids](#output\_privatelink\_vpc\_endpoint\_ids) | The IDs of the VPC Endpoints. |
| <a name="output_privatelink_vpc_endpoint_service_id"></a> [privatelink\_vpc\_endpoint\_service\_id](#output\_privatelink\_vpc\_endpoint\_service\_id) | The ID of the VPC Endpoint Service. |
| <a name="output_privatelink_vpc_endpoint_service_resource_ids"></a> [privatelink\_vpc\_endpoint\_service\_resource\_ids](#output\_privatelink\_vpc\_endpoint\_service\_resource\_ids) | The IDs of the VPC Endpoints. |
| <a name="output_privatelink_vpc_endpoint_zone_ids"></a> [privatelink\_vpc\_endpoint\_zone\_ids](#output\_privatelink\_vpc\_endpoint\_zone\_ids) | The IDs of the VPC Endpoints. |
| <a name="output_route_table_app_vpc_ids"></a> [route\_table\_app\_vpc\_ids](#output\_route\_table\_app\_vpc\_ids) | The IDs of the app VPC Route Tables. |
| <a name="output_route_table_gwlbe_vpc_id"></a> [route\_table\_gwlbe\_vpc\_id](#output\_route\_table\_gwlbe\_vpc\_id) | The ID of the GWLB VPC Route Table. |
| <a name="output_route_table_ipv4_gateway_id"></a> [route\_table\_ipv4\_gateway\_id](#output\_route\_table\_ipv4\_gateway\_id) | The ID of the IPv4 Gateway Route Table. |
| <a name="output_security_vpc_id"></a> [security\_vpc\_id](#output\_security\_vpc\_id) | The ID of the security VPC. |
| <a name="output_security_vswitch_ids"></a> [security\_vswitch\_ids](#output\_security\_vswitch\_ids) | The IDs of the security VSwitches. |
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)
