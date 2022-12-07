# 创建 instance
resource "aws_instance" "ubuntu_server" {
  ami                         = var.ami # Amazon image Id
  instance_type               = "t2.micro" 
  subnet_id                   = var.subnet_id
  security_groups             = [var.security_groups] #
  associate_public_ip_address = true 
  key_name                    = var.key_name 
  connection {                                                 
    user        = "ubuntu" 
    private_key = var.private_key 
    host        = self.public_ip
  }
  tags = {
    Name = var.name
  }
  lifecycle {
    ignore_changes = [security_groups]
  }

# INSTALL emqx service
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "curl -s https://assets.emqx.com/scripts/install-emqx-deb.sh | sudo bash",
      "sudo apt-get install emqx",
      "sudo systemctl start emqx",
    ]
  }
}