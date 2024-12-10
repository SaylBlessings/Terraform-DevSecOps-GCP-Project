resource "google_compute_firewall" "security-automation-fw" {
  name    = "security-automation-fw"
  network = google_compute_network.security-automation-network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  source_tags = ["web"]
}

resource "google_compute_network" "security-automation-network" {
  name = "security-automation-network"
}

