module "nat_label" {
  source = "cloudposse/label/null"

  attributes = ["nat"]

  context = module.this.context
}

locals {
  nat_gateways_count      = var.nat_gateway_enabled && ! local.use_existing_eips && !var.single_nat ? length(var.availability_zones) : var.single_nat ? 1 : 0
  nat_gateway_eip_count   = local.use_existing_eips ? 0 : local.nat_gateways_count
  gateway_eip_allocations = local.use_existing_eips ? data.aws_eip.nat_ips.*.id : aws_eip.default.*.id
  eips_allocations        = local.use_existing_eips ? data.aws_eip.nat_ips.*.id : aws_eip.default.*.id
}

resource "aws_eip" "default" {
  count = local.enabled ? local.nat_gateway_eip_count : 0
  vpc   = true

  tags = merge(
    module.private_label.tags,
    {
      "Name" = format("%s%s%s", module.private_label.id, local.delimiter, local.az_map[element(var.availability_zones, count.index)])
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "default" {
  count         = local.enabled && !var.single_nat ? local.nat_gateways_count : 0
  allocation_id = element(local.gateway_eip_allocations, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)

  tags = merge(
    module.nat_label.tags,
    {
      "Name" = format("%s%s%s", module.nat_label.id, local.delimiter, local.az_map[element(var.availability_zones, count.index)])
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route" "default" {
  count                  = local.enabled && !var.single_nat? local.nat_gateways_count : 0
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  nat_gateway_id         = element(aws_nat_gateway.default.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_route_table.private]

  timeouts {
    create = var.aws_route_create_timeout
    delete = var.aws_route_delete_timeout
  }
}

resource "aws_nat_gateway" "single_nat" {
  count         = local.enabled && var.single_nat ? 1 : 0
  allocation_id = element(local.gateway_eip_allocations, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)

  tags = merge(
    module.nat_label.tags,
    {
      "Name" = format("%s%s%s", module.nat_label.id, local.delimiter, local.az_map[element(var.availability_zones, count.index)])
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route" "single_nat_routes" {
  count                  = local.enabled && var.single_nat? local.availability_zones_count : 0
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  nat_gateway_id         = aws_nat_gateway.single_nat.0.id
  destination_cidr_block = "0.0.0.0/0"
  depends_on             = [aws_route_table.private]

  timeouts {
    create = var.aws_route_create_timeout
    delete = var.aws_route_delete_timeout
  }
}