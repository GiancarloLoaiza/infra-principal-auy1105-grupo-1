# Guia nota maxima - Evaluacion Parcial 2 (AUY1105)

Esta guia resume exactamente que demostrar para alcanzar el 100% en cada indicador.

## 1) Requisito de repositorios

Modo solicitado: publicar un solo repositorio principal en GitHub, subiendo toda la carpeta repos.

Nombre sugerido:

- infra-principal-auy1105-grupo-1

Estructura sugerida dentro del repo principal:

- repos/infra-principal-auy1105-grupo-1
- repos/terraform-aws-vpc-auy1105-grupo-1
- repos/terraform-aws-ec2-auy1105-grupo-1

Nota importante:
La pauta original solicita 3 repositorios separados. Esta adaptacion simplifica la entrega, pero podria afectar puntaje en ese criterio.

## 2) Estructura minima obligatoria por repositorio

Cada repositorio debe tener:

- README.md
- CHANGELOG.md
- .gitignore
- versions.tf

Cada modulo debe tener ademas:

- main.tf
- variables.tf
- outputs.tf
- examples/basic/README.md
- examples/basic/main.tf

## 3) Evidencia tecnica para IE3.1.1 (33%)

Para maximo puntaje debes demostrar:

- Modulos desacoplados y reutilizables.
- Variables claras y parametrizadas.
- Outputs utiles para integrar entre modulos.
- Integracion real desde repositorio principal.

En esta entrega ya estan implementados:

- Modulo red: VPC, subredes, ruta publica y security groups.
- Modulo computo: EC2 reusable con AMI dinamica.
- Repositorio principal: consume ambos modulos y expone outputs.

## 4) Evidencia documental para IE3.2.1 (33%)

Para maximo puntaje debes demostrar:

- README claro por repositorio.
- Ejemplos funcionales en carpeta examples.
- Variables y outputs con descripcion clara.
- Dependencias y uso explicados.

En esta entrega ya estan:

- README y CHANGELOG completos en la carpeta principal y en cada carpeta de modulo.
- examples/basic funcional en ambos modulos.

## 5) Evidencia versionado para IE3.3.1 (34%)

Debes aplicar Semantic Versioning y release en GitHub.

Secuencia recomendada en repositorio unico:

1. Commit inicial de estructura completa.
2. Tag general v0.1.0
3. Commits de mejoras y documentacion.
4. Tag general v1.0.0
5. Release v1.0.0 con descripcion de cambios.

Opcional para distinguir modulos en repo unico:

- Tag vpc-v0.1.0 y vpc-v1.0.0
- Tag ec2-v0.1.0 y ec2-v1.0.0

Plantilla de comandos:

git init
git add .
git commit -m "feat: estructura base de repos"
git tag v0.1.0
git add .
git commit -m "feat: version estable de repos"
git tag v1.0.0
git remote add origin URL_DEL_REPOSITORIO
git branch -M main
git push -u origin main
git push origin v0.1.0
git push origin v1.0.0

## 6) Pipeline de validacion y seguridad

Repositorio principal incluye workflow GitHub Actions con:

- terraform fmt -check -recursive
- terraform validate
- tflint
- tfsec
- checkov

Eso cumple la exigencia de mantener/adaptar validacion estatica y seguridad.

## 7) Ejecucion local sugerida

En repositorio principal:

1. Copiar terraform.tfvars.example a terraform.tfvars
2. Ajustar key_name, region y otros valores
3. Ejecutar:
   - terraform init
   - terraform fmt -check -recursive
   - terraform validate
   - terraform plan
   - terraform apply

## 8) Checklist final antes de entregar

- Existe un repositorio principal publico o compartido con docente.
- Cada integrante tiene commits con su usuario GitHub personal.
- README y CHANGELOG actualizados en carpeta principal y modulos.
- Modulos tienen examples funcionales.
- Existen tags v0.1.0 y v1.0.0 en el repositorio principal.
- Existe release en GitHub para version estable.
- Repositorio principal contiene y orquesta los modulos.
- Capturas o enlaces de evidencia de ejecucion y pipeline exitoso.
