resource "google_compute_network" "vpc" {
  name                    = "${local.name_prefix}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${local.name_prefix}-subnet"
  region        = var.region
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.vpc.id
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "${local.name_prefix}-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["tp-ssh"]
}

resource "google_compute_firewall" "allow_web" {
  name    = "${local.name_prefix}-web"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = [tostring(var.web_port)]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["tp-web"]
}

