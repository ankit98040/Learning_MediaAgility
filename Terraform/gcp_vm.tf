provider "google" {
  project = "playground-s-11-306a48b7"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_instance" "resource_name" {
  name         = "test"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  allow_stopping_for_update = true

    network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}

output "extip" {
	value = google_compute_instance.resource_name.network_interface.0.access_config.0.nat_ip
}

