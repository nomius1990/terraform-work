# add nlb
resource "alicloud_nlb_load_balancer" "default" {
  load_balancer_name = var.name
  load_balancer_type = var.type
  address_type       = "Internet"
  address_ip_version = "Ipv4"
  tags = {
    Created = "Terraform-MQTT"
    For     = "Tftestacc 0"
  }
  vpc_id = var.vpc_id

  dynamic "zone_mappings" {
    for_each = var.zone_mappings
    content {
      vswitch_id = zone_mappings.value.id
      zone_id    = zone_mappings.value.zone_id
    }
  }
}

resource "alicloud_nlb_server_group" "default" {
  server_group_name = "${var.name}-server-group"
  server_group_type = "Instance"
  vpc_id            = var.vpc_id
  scheduler         = "Wrr"
  protocol          = "TCP"
  health_check {
    health_check_enabled         = true
    health_check_type            = "TCP"
    healthy_threshold            = 2
    unhealthy_threshold          = 2
    health_check_connect_timeout = 5
    health_check_interval        = 10
    http_check_method            = "GET"
  }
}

resource "alicloud_nlb_listener" "default" {
  count             = length(var.listener_port)
  listener_protocol = "TCP"
  listener_port     = var.listener_port[count.index]
  load_balancer_id  = alicloud_nlb_load_balancer.default.id
  server_group_id   = alicloud_nlb_server_group.default.id
}