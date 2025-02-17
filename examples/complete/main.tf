provider "alicloud" {
  region = "cn-wulanchabu"
}

module "complete" {
  source = "../.."

  vpc_security = var.vpc_security
  vpc_app      = var.vpc_app
  zone_ids     = var.zone_ids
  vswitches    = var.vswitches

  gwlb_server_group = var.gwlb_server_group
}
