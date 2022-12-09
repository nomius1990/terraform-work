variable "min_size" {
  type = number
  description = "Minimum number of ECS instances in the scaling group"
  default = 1
}

variable "max_size" {
  type = number
  description = "Maximum number of ECS instances in the scaling group"
  default = 10
}

variable "desired_capacity" {
  type = number
  description = "Expected number of ECS instances in the scaling group"
  default = 1
}

variable "default_cooldown" {
  type = number
  description = "Default cool-down time (in seconds) of the scaling group"
  default = 300
}

variable "vswitch_ids" {
  type = list(string)
  description = "List of virtual switch IDs in which the ecs instances to be launched"
  default = null
}


variable "loadbalancer_ids"{
  type = list(string)
  description = "If a Server Load Balancer instance is specified in the scaling group, the scaling group automatically attaches its ECS instances to the Server Load Balancer instance"
  default = null
}

variable "scaling_group_name" {
  type = string
  description = "Name shown for the scaling group"
  default = "MQTT-autoscale"
}

variable "image_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "internet_max_bandwidth_out" {
  type = number
  default = 10
}