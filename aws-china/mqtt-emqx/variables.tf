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