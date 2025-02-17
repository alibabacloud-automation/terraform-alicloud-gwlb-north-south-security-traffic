variable "vpc_security" {
  type = object({
    vpc_name   = optional(string, "vpc-security")
    cidr_block = string
  })
  description = "The configuration of security vpc."
  default = {
    cidr_block = "172.16.0.0/16"
  }
}

variable "vpc_app" {
  type = object({
    vpc_name   = optional(string, "vpc-app")
    cidr_block = string
  })
  description = "The configuration of app vpc."
  default = {
    cidr_block = "192.168.0.0/16"
  }
}

variable "zone_ids" {
  type        = list(string)
  description = "The zone ids of vswitches. The length of this list must be two."

  validation {
    condition     = length(var.zone_ids) == 2
    error_message = "The length of zone_ids must be two."
  }
  default = ["cn-wulanchabu-b", "cn-wulanchabu-c"]
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
  default = {
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
  default = {
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

