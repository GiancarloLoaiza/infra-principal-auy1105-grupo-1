output "instance_id" {
  description = "ID de la primera instancia creada."
  value       = aws_instance.this[0].id
}

output "instance_ip" {
  description = "IP publica de la primera instancia creada."
  value       = aws_instance.this[0].public_ip
}

output "instance_ids" {
  description = "Lista de IDs de todas las instancias creadas."
  value       = [for i in aws_instance.this : i.id]
}

output "instance_public_ips" {
  description = "Lista de IPs publicas de todas las instancias creadas."
  value       = [for i in aws_instance.this : i.public_ip]
}
