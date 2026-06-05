output "vpc_id" {
  description = "ID de la VPC creada."
  value       = aws_vpc.this.id
}

output "subnet_ids" {
  description = "Mapa de IDs de subredes creadas."
  value       = { for name, subnet in aws_subnet.this : name => subnet.id }
}

output "security_group_ids" {
  description = "Mapa de IDs de security groups creados."
  value       = { for name, sg in aws_security_group.this : name => sg.id }
}
