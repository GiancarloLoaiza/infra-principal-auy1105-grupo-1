locals {
  common_tags = merge(var.tags, {
    module = "terraform-aws-vpc"
  })

  public_subnet_keys = [for name, subnet in var.subnets : name if subnet.public]
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.common_tags, {
    Name = "${var.name_prefix}-vpc"
  })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(local.common_tags, {
    Name = "${var.name_prefix}-igw"
  })
}

resource "aws_subnet" "this" {
  for_each = var.subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.public

  tags = merge(local.common_tags, {
    Name = "${var.name_prefix}-${each.key}"
    Tier = each.value.public ? "public" : "private"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(local.common_tags, {
    Name = "${var.name_prefix}-public-rt"
  })
}

resource "aws_route_table_association" "public" {
  for_each = toset(local.public_subnet_keys)

  subnet_id      = aws_subnet.this[each.value].id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "this" {
  for_each = var.security_groups

  name        = "${var.name_prefix}-${each.key}"
  description = each.value.description
  vpc_id      = aws_vpc.this.id

  tags = merge(local.common_tags, {
    Name = "${var.name_prefix}-${each.key}"
  })
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = {
    for rule in flatten([
      for sg_name, sg in var.security_groups : [
        for idx, ingress in sg.ingress : {
          key         = "${sg_name}-ingress-${idx}"
          sg_name     = sg_name
          from_port   = ingress.from_port
          to_port     = ingress.to_port
          ip_protocol = ingress.protocol
          cidr_blocks = ingress.cidr_blocks
        }
      ]
    ]) : rule.key => rule
  }

  security_group_id = aws_security_group.this[each.value.sg_name].id
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  ip_protocol       = each.value.ip_protocol
  cidr_ipv4         = each.value.cidr_blocks[0]
}

resource "aws_vpc_security_group_egress_rule" "this" {
  for_each = {
    for rule in flatten([
      for sg_name, sg in var.security_groups : [
        for idx, egress in sg.egress : {
          key         = "${sg_name}-egress-${idx}"
          sg_name     = sg_name
          from_port   = egress.from_port
          to_port     = egress.to_port
          ip_protocol = egress.protocol
          cidr_blocks = egress.cidr_blocks
        }
      ]
    ]) : rule.key => rule
  }

  security_group_id = aws_security_group.this[each.value.sg_name].id
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  ip_protocol       = each.value.ip_protocol
  cidr_ipv4         = each.value.cidr_blocks[0]
}
