resource "null_resource" "acceptance" {
  count = "${var.host_count}"

  triggers {
    cluster_instance_ids = "${join(",", google_compute_instance.nomad-host.*.id)}"
  }

  connection {
    type = "ssh"

    # host        = "${element(google_compute_instance.nomad-host.*.network_interface.0.access_config.0.assigned_nat_ip, 0)}"
    host        = "${element(google_compute_instance.nomad-host.*.network_interface.0.access_config.0.assigned_nat_ip, count.index)}"
    user        = "root"
    private_key = "${file("${var.private_key_path}")}"
    agent       = false
  }

  provisioner "file" {
    #source      = "test/goss-nomad.yaml"
    source      = "${count.index == "0" ? var.goss_server_test : var.goss_slave_test}"
    destination = "/root/goss-nomad.yaml"
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 40 && goss -g goss-nomad.yaml validate --format documentation",
    ]
  }
}
