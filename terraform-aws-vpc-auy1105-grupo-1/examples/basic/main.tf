terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "../../"

  name_prefix = "vpc-example"
  vpc_cidr    = "10.30.0.0/16"

  subnets = {
    public_a = {
      cidr_block        = "10.30.1.0/24"
      availability_zone = "us-east-1a"
      public            = true
    }
    private_a = {
      cidr_block        = "10.30.11.0/24"
      availability_zone = "us-east-1a"
      public            = false
    }
  }

  security_groups = {
    web = {
      description = "SG para trafico web y SSH"
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

  tags = {
    environment = "dev"
    owner       = "grupo-1"
  }
}

output "vpc_id" {
  value = module.network.vpc_id
}
