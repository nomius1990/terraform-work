variable "ami" {
  default = "ami-09b18720cb71042df"
}
variable "subnet_id" {}
variable "security_groups" {}
variable "name" {}
variable "key_name" {}
variable "private_key" {}
variable "access_key" {}
variable "secret_key" {}
variable "region" {}

variable "volume_id" {
  type = string
  validation {
    condition     = length(var.volume_id) > 10
    error_message = "The Volume Id length must over 10."
  }
  validation {
    condition     = can(regex("^vol-", var.volume_id))
    error_message = "The volume id must start with vol"
  }
}

variable "filename" {
  type    = string
  default = "volume-backup"
}

variable "s3-bucket" {
  type = string
  validation {
    condition     = length(var.s3-bucket) > 5
    error_message = "The bucket name length should over 10"
  }
}