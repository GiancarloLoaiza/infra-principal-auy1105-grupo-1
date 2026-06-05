# infra-principal-auy1105-grupo-1

Repositorio principal para orquestar modulos Terraform desacoplados de red y computo.

## Objetivo

- Integrar modulo VPC y modulo EC2 desde una configuracion de alto nivel.
- Ejecutar validacion estatica y seguridad en CI.
- Mantener trazabilidad de cambios con CHANGELOG y versionado.

## Estructura

- main.tf: invoca modulos de red y computo.
- variables.tf: variables de alto nivel.
- outputs.tf: salidas consolidadas.
- versions.tf: versiones Terraform/proveedor.
- .github/workflows/terraform-ci.yml: validacion automatizada.

## Requisitos

- Terraform >= 1.6.0
- Credenciales AWS configuradas (AWS CLI o variables de entorno)

## Uso local

1. Copiar terraform.tfvars.example a terraform.tfvars y ajustar valores.
2. Ejecutar:
   - terraform init
   - terraform fmt -check
   - terraform validate
   - terraform plan
   - terraform apply

## Integracion recomendada con GitHub tags

Cuando publiques los modulos, cambia source en main.tf a:

```hcl
module "network" {
  source = "github.com/GiancarloLoaiza/terraform-aws-vpc-auy1105-grupo-1?ref=v1.0.0"
  # ...
}

module "compute" {
  source = "github.com/GiancarloLoaiza/terraform-aws-ec2-auy1105-grupo-1?ref=v1.0.0"
  # ...
}
```

## Evidencia para la evaluacion

- Commits descriptivos por cambio.
- Releases y tags semanticos en cada modulo.
- README y CHANGELOG actualizados en los tres repositorios.
