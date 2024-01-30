locals {
  enabled = module.this.enabled

  ipv4_primary_cidr_block          = var.ipv4_primary_cidr_block
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block
  dns_hostnames_enabled            = var.dns_hostnames_enabled
  dns_support_enabled              = var.dns_support_enabled
  default_security_group_deny_all  = local.enabled && var.default_security_group_deny_all
  internet_gateway_enabled         = local.enabled && var.internet_gateway_enabled
}

module "label" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  context = module.this.context
}

resource "aws_vpc" "default" {
  count = local.enabled ? 1 : 0

  cidr_block                           = local.ipv4_primary_cidr_block
  instance_tenancy                     = var.instance_tenancy
  enable_dns_hostnames                 = local.dns_hostnames_enabled
  enable_dns_support                   = local.dns_support_enabled
  assign_generated_ipv6_cidr_block     = local.assign_generated_ipv6_cidr_block
  tags                                 = module.label.tags
}

resource "aws_internet_gateway" "default" {
  count = local.internet_gateway_enabled ? 1 : 0

  vpc_id = aws_vpc.default[0].id
  tags   = module.label.tags
}