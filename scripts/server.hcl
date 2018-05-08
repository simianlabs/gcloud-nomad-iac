log_level = "DEBUG"

data_dir = "/opt/nomad/tmp"

# Enable the server
server {
  enabled          = true
  bootstrap_expect = 1
}
