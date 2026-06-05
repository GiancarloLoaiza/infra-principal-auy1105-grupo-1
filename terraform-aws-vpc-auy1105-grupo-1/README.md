# terraform-aws-vpc-auy1105-grupo-1

Modulo Terraform para crear capa de red en AWS con VPC, subredes, tabla de ruta publica e instancias de security group.

## Objetivos

- Desacoplar la capa de red para reutilizacion.
- Permitir integracion simple desde un repositorio principal.
- Exponer salidas clave para otros modulos.

## Recursos creados

- aws_vpc
- aws_internet_gateway
- aws_subnet
- aws_route_table y asociaciones para subredes publicas
- aws_security_group con reglas de ingreso/salida

## Inputs principales

- name_prefix: prefijo de nombres.
- vpc_cidr: CIDR de VPC.
- subnets: mapa de subredes.
- security_groups: mapa de grupos de seguridad y reglas.
- tags: etiquetas comunes.

## Outputs

- vpc_id
- subnet_ids
- security_group_ids

## Uso rapido

```hcl
module "network" {
  source      = "github.com/TU_USUARIO/terraform-aws-vpc-auy1105-grupo-1?ref=v1.0.0"
  name_prefix = "eva2"
  vpc_cidr    = "10.20.0.0/16"

  subnets = {
    public_a = {
      cidr_block        = "10.20.1.0/24"
      availability_zone = "us-east-1a"
      public            = true
    }
  }

  security_groups = {
    web = {
      description = "Acceso web y SSH"
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
}
```

## Ejemplos

Ver carpeta examples/basic para una implementacion funcional.
