# Despliegue

Vamos a utilizar terraform.
Lo primero es habilitar los proveedores, desde la carpeta donde se encuentra terraform

```
cd iac
```

```
terraform init
```

Deben documentar como crear los ambientes y seleccionar los ambientes

terraform.tfvars:

```hcl
web_port = {
  localhost = 4001
  dev = 5001
}
api_port = {
  localhost = 4002
  dev = 5002
}
bd_port = {
  localhost = 4003
  dev = 5003
}


Construcción de imágenes
Antes de iniciar Terraform, construir las imágenes locales:
```bash
docker build -t lab/api ./src/api
docker build -t lab/web ./src/web


cd iac
terraform init
terraform workspace new localhost
terraform apply -auto-approve

terraform workspace new dev
terraform apply -auto-approve

docker ps