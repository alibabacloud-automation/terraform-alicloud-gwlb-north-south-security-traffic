
# Complete

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_complete"></a> [complete](#module\_complete) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gwlb_server_group"></a> [gwlb\_server\_group](#input\_gwlb\_server\_group) | Configuration for the GWLB server group. | <pre>object({<br>    scheduler = optional(string, "5TCH")<br>    health_check_config = optional(object({<br>      health_check_protocol        = optional(string, "TCP")<br>      health_check_connect_port    = optional(number, 80)<br>      health_check_connect_timeout = optional(number, 5)<br>      health_check_domain          = optional(string, null)<br>      health_check_enabled         = optional(bool, true)<br>      health_check_http_code       = optional(list(string), null)<br>      health_check_interval        = optional(number, 10)<br>      health_check_path            = optional(string, null)<br>      healthy_threshold            = optional(number, 2)<br>      unhealthy_threshold          = optional(number, 2)<br>    }), {})<br>    protocol          = optional(string, "GENEVE")<br>    server_group_type = optional(string, "Ip")<br>    connection_drain_config = optional(object({<br>      connection_drain_enabled = optional(bool, true)<br>      connection_drain_timeout = optional(number, 1)<br>    }), {})<br>    servers = optional(list(object({<br>      server_id   = string<br>      server_ip   = string<br>      server_type = string<br>    })), [])<br>    server_group_name = optional(string, null)<br>  })</pre> | <pre>{<br>  "servers": [<br>    {<br>      "server_id": "172.16.1.100",<br>      "server_ip": "172.16.1.100",<br>      "server_type": "Ip"<br>    },<br>    {<br>      "server_id": "172.16.2.100",<br>      "server_ip": "172.16.2.100",<br>      "server_type": "Ip"<br>    }<br>  ]<br>}</pre> | no |
| <a name="input_vpc_app"></a> [vpc\_app](#input\_vpc\_app) | The configuration of app vpc. | <pre>object({<br>    vpc_name   = optional(string, "vpc-app")<br>    cidr_block = string<br>  })</pre> | <pre>{<br>  "cidr_block": "192.168.0.0/16"<br>}</pre> | no |
| <a name="input_vpc_security"></a> [vpc\_security](#input\_vpc\_security) | The configuration of security vpc. | <pre>object({<br>    vpc_name   = optional(string, "vpc-security")<br>    cidr_block = string<br>  })</pre> | <pre>{<br>  "cidr_block": "172.16.0.0/16"<br>}</pre> | no |
| <a name="input_vswitches"></a> [vswitches](#input\_vswitches) | The configuration of vswitches. | <pre>object({<br>    security = object({<br>      vswitch_name_prefix = optional(string, "vsw-security")<br>      cidr_block          = list(string)<br>    })<br>    gwlbe = object({<br>      vswitch_name_prefix = optional(string, "vsw-gwlb")<br>      cidr_block          = list(string)<br>    })<br>    app = object({<br>      vswitch_name_prefix = optional(string, "vsw-app")<br>      cidr_block          = list(string)<br>    })<br>  })</pre> | <pre>{<br>  "app": {<br>    "cidr_block": [<br>      "192.168.1.0/24",<br>      "192.168.2.0/24"<br>    ]<br>  },<br>  "gwlbe": {<br>    "cidr_block": [<br>      "192.168.101.0/28",<br>      "192.168.102.0/28"<br>    ]<br>  },<br>  "security": {<br>    "cidr_block": [<br>      "172.16.1.0/24",<br>      "172.16.2.0/24"<br>    ]<br>  }<br>}</pre> | no |
| <a name="input_zone_ids"></a> [zone\_ids](#input\_zone\_ids) | The zone ids of vswitches. The length of this list must be two. | `list(string)` | <pre>[<br>  "cn-wulanchabu-b",<br>  "cn-wulanchabu-c"<br>]</pre> | no |

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