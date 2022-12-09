resource "alicloud_ess_scaling_group" "auto_scale" {
  min_size           = var.min_size
  max_size           = var.max_size
  scaling_group_name = var.scaling_group_name
  default_cooldown   = var.default_cooldown
  vswitch_ids        = var.vswitch_ids
  desired_capacity = var.desired_capacity
  loadbalancer_ids = var.loadbalancer_ids
}

resource "alicloud_ess_scaling_configuration" "default" {
  scaling_group_id  = alicloud_ess_scaling_group.auto_scale.id
  image_id          = var.image_id
  instance_type     = var.instance_type
  security_group_id = var.security_group_id
  internet_max_bandwidth_out = var.internet_max_bandwidth_out
  force_delete = true
  active            = true
  enable = true
}
