variable "name_prefix" {
  description = "Prefijo para nombrar recursos de computo."
  type        = string
}

variable "instance_count" {
  description = "Cantidad de instancias EC2 a crear."
  type        = number
  default     = 1
}

variable "instance_type" {
  description = "Tipo de instancia EC2."
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "ID de la subred donde se desplegaran las instancias."
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Lista de security groups a asociar a la instancia."
  type        = list(string)
}

variable "key_name" {
  description = "Nombre del key pair de AWS para SSH."
  type        = string
  default     = null
}

variable "ami_id" {
  description = "AMI explicita. Si es null, se usa AMI Amazon Linux 2023 mas reciente."
  type        = string
  default     = null
}

variable "user_data" {
  description = "Script cloud-init opcional para bootstrap de instancia."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags adicionales para todos los recursos."
  type        = map(string)
  default     = {}
}
