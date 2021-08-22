terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "nginx-image" {
  name = "nginx"
}

resource "docker_container" "nginx" {
  image = docker_image.nginx-image.latest
  name  = "nginx"
  ports {
    internal = var.internal_port
    external = var.external_port
    protocol = "tcp"
  }
}


output "url" {
  description = "Browser URL for container site"
  value       = join(":", ["http://localhost", tostring(var.external_port)])
}