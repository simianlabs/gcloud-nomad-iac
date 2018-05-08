log_level = "DEBUG"

data_dir = "/opt/nomad/tmp"

client {
  enabled = true
  servers = ["nomad-01.c.nomad-concept.internal:4647"]
}

ports {
  http = 5656
}
