output "instance_id" {
  value = "${google_compute_instance.nomad-host.*.name}"
}

output "instance_public_ip" {
  value = "${google_compute_instance.nomad-host.*.network_interface.0.access_config.0.assigned_nat_ip}"
}

output "instance_ips" {
  value = "${google_compute_instance.nomad-host.*.network_interface.0.network_ip}"
}
