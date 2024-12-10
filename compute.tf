resource "google_service_account" "security-automation" {
  account_id   = "tessydinma"
  display_name = "Custom SA for VM Instance"
}

resource "google_compute_instance" "security-automation-vm" {
  name         = "security-automation-vm"
  machine_type = "n2-standard-2"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = "default"

    access_config {
      // Public IP
    }
  }

  metadata_startup_script = "./remediation.sh"

  service_account {
    email  = google_service_account.security-automation.email
    scopes = ["cloud-platform"]
  }
}