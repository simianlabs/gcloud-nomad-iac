variable "region" {
  default = "europe-west2"
}

variable "project_name" {
  description = "The ID of the Google Cloud project"
}

variable "ip_cidr_range" {
  description = "Network cidr range"
}

variable "auto_create_subnetworks" {
  default = "false"
}

# variable "dns_zone_name" {}

variable "machine_type" {}

variable "host_count" {}

variable "region_zone" {
  default = "europe-west2-a"
}

variable "host_image" {}

variable "public_key_path" {}

variable "private_key_path" {}

variable "install_script_src_path" {
  default = "scripts/nomad.sh"
}

variable "install_script_dest_path" {
  default = "/tmp/nomad.sh"
}

variable "nomad_server_source_path" {
  default = "scripts/server.hcl"
}

variable "nomad_server_dest_path" {
  default = "/opt/nomad/conf/server.hcl"
}

variable "nomad_slave_source_path" {
  default = "scripts/slave.hcl"
}

variable "nomad_slave_dest_path" {
  default = "/opt/nomad/conf/slave.hcl"
}

variable "nomad_server_service_path" {
  default = "scripts/nomad-server.service"
}

variable "nomad_slave_service_path" {
  default = "scripts/nomad-slave.service"
}

variable "nomad_service_dest_path" {
  default = "/etc/systemd/system/nomad.service"
}

variable "goss_server_test" {
  default = "test/goss-nomad-server.yaml"
}

variable "goss_slave_test" {
  default = "test/goss-nomad-slave.yaml"
}

variable "allow_stopping_for_update" {
  default = "true"
}
