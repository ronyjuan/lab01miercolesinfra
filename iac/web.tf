resource "docker_network" "app_network" {
  name = "net-${terraform.workspace}"
}

resource "docker_container" "bd" {
  name  = "bd-${terraform.workspace}"
  image = "mysql:8.0"
  networks_advanced { name = docker_network.app_network.name }
  ports {
    internal = "3306"
    external = var.bd_port[terraform.workspace]
  }
  env = ["MYSQL_ROOT_PASSWORD=root"]
}

resource "docker_container" "api" {
  name  = "api-${terraform.workspace}-01"
  image = "lab/api"
  networks_advanced { name = docker_network.app_network.name }
  ports {
    internal = "3000"
    external = var.api_port[terraform.workspace]
  }
}

resource "docker_container" "web" {
  name  = "web-${terraform.workspace}-01"
  image = "lab/web"
  networks_advanced { name = docker_network.app_network.name }
  ports {
    internal = "80"
    external = var.web_port[terraform.workspace]
  }
}