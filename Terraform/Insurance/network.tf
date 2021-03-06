#creating vpc with custom

resource "google_compute_network" "testterra" {
  project                 = "poised-vial-319809"
  name                    = "testterra"
  auto_create_subnetworks = false
  mtu                     = 1460
  routing_mode = "GLOBAL"
  
}

#adding subnets
resource "google_compute_subnetwork" "sub1" {
  name          = "test-sub"
  ip_cidr_range = "10.2.0.0/26"
  region        = "us-central1"
  network       = google_compute_network.testterra.id     #to change the vpc id
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.10.0/24"
  }
}


#adding firewall rules with the folloing ports allowing from range all
resource "google_compute_firewall" "ruledef" {
  name    = "testattack"
  network = google_compute_network.testterra.id

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  source_ranges = ["0.0.0.0/0"]
}

