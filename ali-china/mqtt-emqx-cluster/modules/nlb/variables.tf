variable "name" {
  type    = string
  default = "mqtt-nlb"
}

variable "type" {
  type    = string
  default = "Network"
}

variable "vpc_id" {
  type    = string
  default = null
}

variable "zone_mappings" {
  type = list(any)
  default = [
    null
  ]
}

variable "instance_ids" {
  type    = list(any)
  default = [null]
}

variable "listener_port" {
  type    = list(any)
  default = [18083]
  # default = [1883, 8883, 8083, 8084, 18083]
}