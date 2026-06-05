variable "aws_region" {
  description = "Region de AWS para despliegue."
  type        = string
  default     = "us-east-1"
}

variable "name_prefix" {
  description = "Prefijo para los recursos de la infraestructura."
  type        = string
  default     = "eva2"
}

variable "vpc_cidr" {
  description = "CIDR principal de la VPC."
  type        = string
  default     = "10.40.0.0/16"
}

variable "subnets" {
  description = "Mapa de subredes para modulo de red."
  type = map(object({
    cidr_block        = string
    availability_zone = string
    public            = bool
  }))
  default = {
    public_a = {
      cidr_block        = "10.40.1.0/24"
      availability_zone = "us-east-1a"
      public            = true
    }
    private_a = {
      cidr_block        = "10.40.11.0/24"
      availability_zone = "us-east-1a"
      public            = false
    }
  }
}

variable "instance_type" {
  description = "Tipo de instancia EC2."
  type        = string
  default     = "t3.micro"
}

variable "instance_count" {
  description = "Cantidad de instancias a crear."
  type        = number
  default     = 1
}

variable "key_name" {
  description = "Key pair para acceso SSH."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags comunes para recursos."
  type        = map(string)
  default = {
    project = "eva2"
    owner   = "grupo-1"
  }
}
