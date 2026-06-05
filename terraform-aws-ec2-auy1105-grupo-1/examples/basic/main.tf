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

module "compute" {
  source = "../../"

  name_prefix            = "ec2-example"
  instance_count         = 1
  instance_type          = "t3.micro"
  subnet_id              = "subnet-REEMPLAZAR"
  vpc_security_group_ids = ["sg-REEMPLAZAR"]

  tags = {
    environment = "dev"
    owner       = "grupo-1"
  }
}

output "instance_id" {
  value = module.compute.instance_id
}

output "instance_ip" {
  value = module.compute.instance_ip
}
