#here we will be working with the terraform state file

# 3 terraform state commands 1. terraform state list 2. terraform state rm 3. terraform state show

#provider "docker" {}

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

resource "docker_image" "terraform-centos" {
	name = "centos:7"
	keep_locally = true
}

resource "docker_container" "centos" {
	image = docker_image.terraform-centos.latest
	name = "terraform-centos"
	start = true
	command = ["/bin/sleep" , "3000"]
}


#terraform state show docker_container.centos