variable "name_prefix" {
  description = "Prefijo para nombrar recursos de red."
  type        = string

  validation {
    condition     = length(var.name_prefix) > 2
    error_message = "name_prefix debe tener al menos 3 caracteres."
  }
}

variable "vpc_cidr" {
  description = "Bloque CIDR principal de la VPC."
  type        = string
}

variable "subnets" {
  description = "Subredes a crear. La llave del mapa se usa como nombre lógico."
  type = map(object({
    cidr_block        = string
    availability_zone = string
    public            = bool
  }))
}

variable "security_groups" {
  description = "Mapa de security groups y sus reglas."
  type = map(object({
    description = string
    ingress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    egress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
  default = {}
}

variable "tags" {
  description = "Tags adicionales para todos los recursos."
  type        = map(string)
  default     = {}
}
