provider "google" {
  project = "playground-s-11-45ae27d7"
  region  = "us-central1"
  zone    = "us-central1-c"
}

#not using
# resource "google_compute_project_metadata_item" "mykey" {
#   key   = "projectuser"
#   value = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQD1WG9MH3U3UamN72QNioTC0hJL6wbzK/qsF3yNvTdmuVih6tXwGRBTbBY+XvvwYZUicuU3XlkJ7PlJb56KtNXdESO79U2EIZt9gkbJ9SF4riBSzvrVQk3A+AcLuD9/UUHlTSeP+izMlgZnAHdwWSmXoeciB8yE8djPaEDC9n1QGHheJq32bJfzXdqboRU+aVB8OtN0L/Esfno7abKHnTykytGPWjQhYGwsFJ+m/BFs550XHyUIyBO2iRXNro3UOZkadDfhwDS1VYE9lWtD3186j3sYaXiS2c9VMyRzPc5641ReYW4uS7ynUx05/2hTlzDJDmQPI1/DT1bdf8P1q4xtueqvgQSZMze+8w7es//BmNgXmuJG146EvP2imq66tS4A441U5gw0oEO11bb4Fc6ooMjPriD4JCEl7BndhnFTOO6FrKMlztM/eU2TsoM2q60KGYNYJ4IQuJqXkfAJ37cBhACEAuJKnLf7PshcajPLIBgbPODmurMv7ojr3+SxE+hZuNvHRxvt4GQ8hh3fCkHjQtDu48Rsa6yVUwU+h49bvfEmTGF2KA5+lchbXe23jiQWwfIF40HtXWi76dPoiflrLe7CBWVZaLTwCq+aDKFjAQXrpbinD5WKmefC7pvJBXPs9zSaQcCoW6xSWosCvkYmgSO2lw9LDMHv11Cb2uNDLw== projectuser"
# }

resource "google_compute_project_metadata" "my_ssh_key" {
  metadata = {
    ssh-keys = <<EOF
      projectuser:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQD1WG9MH3U3UamN72QNioTC0hJL6wbzK/qsF3yNvTdmuVih6tXwGRBTbBY+XvvwYZUicuU3XlkJ7PlJb56KtNXdESO79U2EIZt9gkbJ9SF4riBSzvrVQk3A+AcLuD9/UUHlTSeP+izMlgZnAHdwWSmXoeciB8yE8djPaEDC9n1QGHheJq32bJfzXdqboRU+aVB8OtN0L/Esfno7abKHnTykytGPWjQhYGwsFJ+m/BFs550XHyUIyBO2iRXNro3UOZkadDfhwDS1VYE9lWtD3186j3sYaXiS2c9VMyRzPc5641ReYW4uS7ynUx05/2hTlzDJDmQPI1/DT1bdf8P1q4xtueqvgQSZMze+8w7es//BmNgXmuJG146EvP2imq66tS4A441U5gw0oEO11bb4Fc6ooMjPriD4JCEl7BndhnFTOO6FrKMlztM/eU2TsoM2q60KGYNYJ4IQuJqXkfAJ37cBhACEAuJKnLf7PshcajPLIBgbPODmurMv7ojr3+SxE+hZuNvHRxvt4GQ8hh3fCkHjQtDu48Rsa6yVUwU+h49bvfEmTGF2KA5+lchbXe23jiQWwfIF40HtXWi76dPoiflrLe7CBWVZaLTwCq+aDKFjAQXrpbinD5WKmefC7pvJBXPs9zSaQcCoW6xSWosCvkYmgSO2lw9LDMHv11Cb2uNDLw== projectuser
    EOF
  }
}

# 2ND WAY TO PASS A FILE AS SSH KEY
# resource "google_compute_project_metadata" "new_key" {
#     metadata = {
#         ssh-keys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
#   }
# }

resource "google_service_account" "service_account_vm" {
  account_id   = "gcpvmtesting98040"
  display_name = "Service Account"
}

resource "google_compute_instance" "vm_wordpress" {
  name         = "wordpress"
  machine_type = "f1-micro"
  zone         = "us-central1-a"


  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "ubuntu-1804-bionic-v20210817"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }



  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.service_account_vm.email
    scopes = ["cloud-platform"]
  }
}

# output "wordpress_ip" {
#     value = gcp_compute_instance.vm_wordpress.network_interface.0.access_config.0.nat_ip
# }