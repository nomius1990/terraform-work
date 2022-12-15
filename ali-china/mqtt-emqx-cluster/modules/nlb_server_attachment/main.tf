
resource "alicloud_nlb_server_group_server_attachment" "default" {
  count           = length(var.ports)
  server_type     = "Ecs"
  server_group_id = var.server_group_id
  server_id       = var.server_id
  port            = var.ports[count.index]
  weight          = 100
}