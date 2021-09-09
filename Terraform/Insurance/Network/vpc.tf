#creating vpc with custom

resource "google_compute_network" "testterra" {
  project                 = "poised-vial-319809"
  name                    = "testterra"
  auto_create_subnetworks = false
  mtu                     = 1460
  routing_mode = "GLOBAL"
}