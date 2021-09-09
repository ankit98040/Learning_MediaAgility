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