resource "alicloud_image" "default" {
  instance_id       = var.instance_id
  image_name        = var.image_name
}