# Increase log verbosity
log_level = "DEBUG"

# Setup data dir
data_dir = "/opt/nomad/tmp"

# Enable the client
client {
  enabled = true

  # For demo assume we are talking to server1. For production,
  # this should be like "nomad.service.consul:4647" and a system
  # like Consul used for service discovery.
  servers = ["nomad-01.c.nomad-concept.internal:4647"]
}

# Modify our port to avoid a collision with server1
ports {
  http = 5656
}
