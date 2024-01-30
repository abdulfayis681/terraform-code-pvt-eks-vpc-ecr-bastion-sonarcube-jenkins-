variable "ipv4_primary_cidr_block" {
  type        = string
  description = <<-EOT
    The primary IPv4 CIDR block for the VPC.
    Either `ipv4_primary_cidr_block` or `ipv4_primary_cidr_block_association` must be set, but not both.
    EOT
  default     = null
}

variable "assign_generated_ipv6_cidr_block" {
  type        = bool
  description = "When `true`, assign AWS generated IPv6 CIDR block to the VPC.  Conflicts with `ipv6_ipam_pool_id`."
  default     = true
}


variable "instance_tenancy" {
  type        = string
  description = "A tenancy option for instances launched into the VPC"
  default     = "default"
  validation {
    condition     = contains(["default", "dedicated", "host"], var.instance_tenancy)
    error_message = "Instance tenancy must be one of \"default\", \"dedicated\", or \"host\"."
  }
}

variable "dns_hostnames_enabled" {
  type        = bool
  description = "Set `true` to enable [DNS hostnames](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-dns.html#vpc-dns-hostnames) in the VPC"
  default     = true
}

variable "dns_support_enabled" {
  type        = bool
  description = "Set `true` to enable DNS resolution in the VPC through the Amazon provided DNS server"
  default     = true
}

variable "default_security_group_deny_all" {
  type        = bool
  default     = true
  description = <<-EOT
    When `true`, manage the default security group and remove all rules, disabling all ingress and egress.
    When `false`, do not manage the default security group, allowing it to be managed by another component.
    EOT
}

variable "internet_gateway_enabled" {
  type        = bool
  description = "Set `true` to create an Internet Gateway for the VPC"
  default     = true
}