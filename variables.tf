variable "vpc_security" {
  type = object({
    vpc_name   = optional(string, "vpc-security")
    cidr_block = string
  })
  description = "The configuration of security vpc."
}

variable "vpc_app" {
  type = object({
    vpc_name   = optional(string, "vpc-app")
    cidr_block = string
  })
  description = "The configuration of app vpc."
}

variable "zone_ids" {
  type        = list(string)
  description = "The zone ids of vswitches. The length of this list must be two."

  validation {
    condition     = length(var.zone_ids) == 2
    error_message = "The length of zone_ids must be two."
  }
}

variable "vswitches" {
  type = object({
    security = object({
      vswitch_name_prefix = optional(string, "vsw-security")
      cidr_block          = list(string)
    })
    gwlbe = object({
      vswitch_name_prefix = optional(string, "vsw-gwlb")
      cidr_block          = list(string)
    })
    app = object({
      vswitch_name_prefix = optional(string, "vsw-app")
      cidr_block          = list(string)
    })
  })
  description = "The configuration of vswitches."
}

variable "ipv4_gateway" {
  type = object({
    name        = optional(string, "app")
    description = optional(string, null)
    enabled     = optional(bool, true)
  })
  description = "The configuration of ipv4 gateway."
  default     = {}
}

variable "eip_address" {
  type = object({
    isp                  = optional(string, "BGP")
    bandwidth            = optional(string, "2")
    internet_charge_type = optional(string, "PayByTraffic")
  })
  description = "The configuration of eip address."
  default     = {}
}


variable "gwlb_server_group" {
  description = "Configuration for the GWLB server group."
  type = object({
    scheduler = optional(string, "5TCH")
    health_check_config = optional(object({
      health_check_protocol        = optional(string, "TCP")
      health_check_connect_port    = optional(number, 80)
      health_check_connect_timeout = optional(number, 5)
      health_check_domain          = optional(string, null)
      health_check_enabled         = optional(bool, true)
      health_check_http_code       = optional(list(string), null)
      health_check_interval        = optional(number, 10)
      health_check_path            = optional(string, null)
      healthy_threshold            = optional(number, 2)
      unhealthy_threshold          = optional(number, 2)
    }), {})
    protocol          = optional(string, "GENEVE")
    server_group_type = optional(string, "Ip")
    connection_drain_config = optional(object({
      connection_drain_enabled = optional(bool, true)
      connection_drain_timeout = optional(number, 1)
    }), {})
    servers = optional(list(object({
      server_id   = string
      server_ip   = string
      server_type = string
    })), [])
    server_group_name = optional(string, null)
  })
  default = {}
}

variable "gwlb_listener" {
  description = "Configuration for the GWLB listener."
  type = object({
    listener_description = optional(string, null)
  })
  default = {}
}

variable "ipv4_gateway_routetable_name" {
  type        = string
  default     = "ipv4-gateway-routetable"
  description = "The name of the IPv4 gateway routing table."
}

variable "gwlbe_vpc_routetable_name" {
  type        = string
  default     = "gwlb-vpc-routetable"
  description = "The name of the GWLB VPC routing table."
}

variable "app_vpc_routetable_name" {
  type        = string
  default     = "app-vpc-routetable"
  description = "The name of the app VPC routing table."
}
