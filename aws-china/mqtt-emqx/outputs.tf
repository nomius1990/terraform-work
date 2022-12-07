output "web_link" {
  value = "http://${module.server.server_public_ip}:18083"
}