variable "access_key" {
  type        = string
  description = "AWS access key"
  default     = "Please get from your AWS Console"
}

variable "secret_key" {
  type        = string
  description = "AWS secret key"
  default     = "Please get from your AWS Console"
}
variable "region" {
  type        = string
  description = "AWS Region"
  default     = ""
}

# please 
variable "ami" {
  type        = string
  description = "Please care about this,it depends on your region"
  default     = ""
}

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

variable "s3-bucket" {
  type = string
  validation {
    condition     = length(var.s3-bucket) > 5
    error_message = "The bucket name length should over 10"
  }
}