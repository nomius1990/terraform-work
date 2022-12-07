# Create VPC
module "mqtt_vpc" {
  source       = "./modules/vpc"
  region       = var.region
  namespace    = var.namespace
  vswitch_conf = var.ecs_vswitch_conf
  vpc_cidr     = var.vpc_cidr
}

# Create Security Group
module "mqtt_security_group" {
  source                   = "./modules/security_group"
  namespace                = var.namespace
  security_group_name      = var.security_group_name
  vpc_id                   = module.mqtt_vpc.vpc_id
  ingress_with_cidr_blocks = var.ingress_with_cidr_blocks
  egress_with_cidr_blocks  = var.egress_with_cidr_blocks
}

# Instance
module "mqtt_emqx" {
  source = "./modules/emqx"
  region = var.region

  instance_name              = var.namespace
  image_id                   = var.image_id
  instance_type              = var.instance_type
  system_disk_category       = var.system_disk_category
  system_disk_size           = var.system_disk_size
  internet_max_bandwidth_out = var.internet_max_bandwidth_out
  emqx_package               = var.emqx_package
  security_group_id          = module.mqtt_security_group.security_group_id
  vswitch_ids                = module.mqtt_vpc.vswitch_ids
}