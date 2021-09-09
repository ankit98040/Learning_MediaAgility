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