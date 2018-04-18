provider "google" {
  credentials = "${file("./secret/nomad.json")}"
  project     = "${var.project_name}"
  region      = "${var.region}"
}
