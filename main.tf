resource "google_compute_network" "nomad-network" {
  name                    = "${var.project_name}-network"
  auto_create_subnetworks = "${var.auto_create_subnetworks}"
}

resource "google_compute_subnetwork" "nomad-subnet" {
  name                     = "${var.project_name}-subnet"
  ip_cidr_range            = "${var.ip_cidr_range}"
  network                  = "${google_compute_network.nomad-network.self_link}"
  region                   = "${var.region}"
  private_ip_google_access = "true"
}

resource "google_compute_firewall" "default" {
  name    = "${var.project_name}-firewall"
  network = "${google_compute_network.nomad-network.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "22", "5656", "4647", "4646", "4648"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["default", "nomad-node"]
}

resource "google_compute_instance" "nomad-host" {
  count = "${var.host_count}"

  name         = "nomad-${format("%02d", count.index+1)}"
  machine_type = "${var.machine_type}"
  zone         = "${var.region_zone}"
  tags         = ["nomad-node"]

  boot_disk {
    initialize_params {
      image = "${var.host_image}"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.nomad-subnet.self_link}"

    access_config {
      # Ephemeral
    }
  }

  metadata {
    ssh-keys = "root:${file("${var.public_key_path}")}"
  }

  metadata_startup_script = "${file("scripts/startup.sh")}"

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
    }

    inline = [
      "mkdir -p /opt/nomad/conf",
    ]
  }

  provisioner "file" {
    source      = "${count.index == "0" ? var.nomad_server_source_path : var.nomad_slave_source_path}"
    destination = "${count.index == "0" ? var.nomad_server_dest_path : var.nomad_slave_dest_path}"

    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
    }
  }

  provisioner "file" {
    source      = "${var.install_script_src_path}"
    destination = "${var.install_script_dest_path}"

    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
    }
  }

  provisioner "file" {
    source      = "${count.index == "0" ? var.nomad_server_service_path : var.nomad_slave_service_path}"
    destination = "${var.nomad_service_dest_path}"

    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
    }
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file("${var.private_key_path}")}"
      agent       = false
    }

    inline = [
      "systemctl enable nomad",
    ]
  }
}
