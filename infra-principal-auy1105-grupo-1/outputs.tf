output "vpc_id" {
  description = "VPC creada desde modulo network."
  value       = module.network.vpc_id
}

output "subnet_ids" {
  description = "Subredes creadas desde modulo network."
  value       = module.network.subnet_ids
}

output "instance_id" {
  description = "ID de instancia principal desde modulo compute."
  value       = module.compute.instance_id
}

output "instance_ip" {
  description = "IP publica de instancia principal desde modulo compute."
  value       = module.compute.instance_ip
}
