module "network" {
  source = "../terraform-aws-vpc-auy1105-grupo-1"

  name_prefix = var.name_prefix
  vpc_cidr    = var.vpc_cidr
  subnets     = var.subnets

  security_groups = {
    web = {
      description = "Permite SSH y HTTP"
      ingress = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
      egress = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  }

  tags = var.tags
}

module "compute" {
  source = "../terraform-aws-ec2-auy1105-grupo-1"

  name_prefix            = "${var.name_prefix}-ec2"
  instance_count         = var.instance_count
  instance_type          = var.instance_type
  subnet_id              = module.network.subnet_ids["public_a"]
  vpc_security_group_ids = [module.network.security_group_ids["web"]]
  key_name               = var.key_name
  tags                   = var.tags
}
