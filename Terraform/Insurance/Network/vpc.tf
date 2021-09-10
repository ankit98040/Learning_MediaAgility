#creating vpc with custom

resource "google_compute_network" "testterra" {
  project                 = var.project
  name                    = var.vpc_name
  auto_create_subnetworks = false
  mtu                     = 1460
  routing_mode = "GLOBAL"
}