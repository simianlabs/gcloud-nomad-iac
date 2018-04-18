# resource "google_dns_managed_zone" "nomad-dns" {
#   name        = "nomad-dns"
#   dns_name    = "${var.dns_zone_name}."
#   description = "Nomad DNS zone"
# }
# resource "google_dns_record_set" "nomad-host-set" {
#   count = "${var.host_count}"
#   # name = "frontend.${google_dns_managed_zone.nomad-dns.dns_name}"
#   name = "${element(google_compute_instance.nomad-host.*.id, count.index)}.${google_dns_managed_zone.nomad-dns.dns_name}"
#   type = "A"
#   ttl  = 300
#   managed_zone = "${google_dns_managed_zone.nomad-dns.name}"
#   rrdatas = ["${element(google_compute_instance.nomad-host.*.network_interface.0.access_config.0.assigned_nat_ip, count.index)}"]
#   # rrdatas = ["${google_compute_instance.frontend.network_interface.0.access_config.0.assigned_nat_ip}"]
# }

