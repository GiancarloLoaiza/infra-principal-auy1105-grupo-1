# terraform-aws-ec2-auy1105-grupo-1

Modulo Terraform para desplegar una o mas instancias EC2 reutilizables.

## Objetivos

- Desacoplar la capa de computo.
- Consumir subred y security groups desde modulo de red.
- Entregar outputs minimos requeridos para integracion.

## Recursos creados

- aws_instance
- data.aws_ami (Amazon Linux 2023 cuando ami_id no se define)

## Inputs principales

- name_prefix
- instance_count
- instance_type
- subnet_id
- vpc_security_group_ids
- key_name
- ami_id
- user_data
- tags

## Outputs

- instance_id
- instance_ip
- instance_ids
- instance_public_ips

## Uso rapido

```hcl
module "compute" {
  source                 = "github.com/TU_USUARIO/terraform-aws-ec2-auy1105-grupo-1?ref=v1.0.0"
  name_prefix            = "eva2-ec2"
  subnet_id              = "subnet-123456"
  vpc_security_group_ids = ["sg-123456"]
  instance_type          = "t3.micro"
}
```

## Ejemplos

Ver examples/basic para referencia funcional.
