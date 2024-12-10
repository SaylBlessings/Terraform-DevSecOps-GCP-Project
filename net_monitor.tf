resource "google_compute_network" "internal_network" {
  name          = "internal-network"
  auto_create_subnetworks = false

  # Define custom routes if needed
  routing_mode = "REGIONAL"
  
}

resource "google_compute_firewall" "internal_firewall" {
  name        = "allow-internal-traffic"
  network     = google_compute_network.internal_network.name
  # Specify project if omitted

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  # Specify source IP ranges, targets, or other conditions as needed
  source_ranges = ["10.0.0.0/8"]
  target_tags   = ["internal-server"]
}
