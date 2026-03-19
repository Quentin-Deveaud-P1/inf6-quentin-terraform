resource "google_compute_network" "vpc" {
  name                    = "tp-quentin-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "tp-quentin-subnet"
  region        = var.region
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.vpc.id
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "tp-quentin-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["tp-ssh"]
}

resource "google_compute_firewall" "allow-web" {
  name    = "tp-quentin-web"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-web"]
}

