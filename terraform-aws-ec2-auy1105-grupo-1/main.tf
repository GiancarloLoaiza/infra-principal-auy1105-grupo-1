locals {
  common_tags = merge(var.tags, {
    module = "terraform-aws-ec2"
  })
}

data "aws_ami" "al2023" {
  count       = var.ami_id == null ? 1 : 0
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_instance" "this" {
  count = var.instance_count

  ami                         = var.ami_id != null ? var.ami_id : data.aws_ami.al2023[0].id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids
  key_name                    = var.key_name
  user_data                   = var.user_data
  associate_public_ip_address = true

  tags = merge(local.common_tags, {
    Name = "${var.name_prefix}-${count.index + 1}"
  })
}
