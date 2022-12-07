variable "access_key" {
  type        = string
  description = "AWS access key"
  default     = null
}

variable "secret_key" {
  type        = string
  description = "AWS secret key"
  default     = null
}

variable "region" {
  type        = string
  description = "alicloud region"
  default     = "cn-shenzhen"
}

variable "namespace" {
  type        = string
  default     = "tf-emqx"
  description = "namespace"
}

variable "intance_pwd" {
  type        = string
  description = "instance password"
  default     = "password"
}

variable "vpc_cidr" {
  type        = string
  default     = ""
  description = "cidr of vpc"
}

variable "ecs_vswitch_conf" {
  type        = list(any)
  default     = []
  description = "vswitch configurations"
}

variable "security_group_name" {
  type        = string
  default     = "mqtt-security-group"
  description = "security group name"
}

variable "ingress_with_cidr_blocks" {
  type        = list(any)
  default     = [null]
  description = "ingress of emqx with cidr blocks"
}

variable "egress_with_cidr_blocks" {
  type        = list(any)
  default     = [null]
  description = "egress with cidr blocks"
}

## Ecs

variable "image_id" {
  type        = string
  default     = "ubuntu_20_04_x64_20G_alibase_20210623.vhd"
  description = "image id"
}

variable "instance_type" {
  type        = string
  default     = "ecs.t6-c1m1.large"
  description = "instance type"
}

variable "system_disk_category" {
  type        = string
  default     = "cloud_efficiency"
  description = "system disk category"
}

variable "system_disk_size" {
  type        = number
  default     = 50
  description = "system disk size"
}

variable "internet_max_bandwidth_out" {
  type        = number
  default     = 10
  description = "internet max bandwidth out"
}

variable "emqx_package" {
  type        = string
  default     = ""
  description = "emqx package path"
}