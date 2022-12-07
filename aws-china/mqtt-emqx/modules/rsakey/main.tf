variable "pemname" {}
variable "awskeyname" {}

resource "tls_private_key" "prikey" {
  algorithm = "RSA"
}

resource "local_file" "pripem" {
  content  = tls_private_key.prikey.private_key_pem
  filename = var.pemname
}

# add the key to AWS CLOUD
resource "aws_key_pair" "awspubkey" {
  key_name   = var.awskeyname
  public_key = tls_private_key.prikey.public_key_openssh
  lifecycle {
    ignore_changes = [key_name]
  }
}

output "public_key_name" {
    value = aws_key_pair.awspubkey.key_name
}

output "private_key_pem" {
  value = tls_private_key.prikey.private_key_pem
}