# 创建 instance
resource "aws_instance" "ubuntu_server" {
  ami                         = var.ami # Amazon image Id
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  security_groups             = [var.security_groups] #
  associate_public_ip_address = true
  key_name                    = var.key_name
  tags = {
    Name = var.name
  }
  lifecycle {
    ignore_changes = [security_groups]
  }

}

# Attachment Volume to instance
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdf"
  volume_id   = var.volume_id
  instance_id = aws_instance.ubuntu_server.id
}

# migrate volume to s3
resource "null_resource" "name-1" {
  connection {
    user        = "ubuntu"
    private_key = var.private_key
    host        = aws_instance.ubuntu_server.public_ip
  }

    # Initial necessary componets
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt install unzip",
      "sudo curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip",
      "sudo unzip awscliv2.zip",
      "sudo ./aws/install",
      "sudo mkdir -p .aws",
      "sudo chmod 777 -R .aws/",
      "sudo echo  '[default]' >> .aws/credentials",
      "sudo echo  'aws_access_key_id=${var.access_key}' >> .aws/credentials",
      "sudo echo  'aws_secret_access_key=${var.secret_key}' >> .aws/credentials",
      "sudo echo  'region=${var.region}' >> .aws/credentials",
      "sudo apt-get update",
      "sudo apt install -y pv",
      "sudo mount /dev/xvdf1 /mnt ",
      "sudo tar c /mnt | sudo pv -s $(($(sudo du -sk /mnt | sudo awk '{print $1}') * 1024)) | sudo gzip | aws s3 cp - 's3://${var.s3-bucket}/${var.filename}.tar.gz'",
      "sudo umount /dev/xvdf1",
    ]
  }
}