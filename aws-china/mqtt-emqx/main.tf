# Configure the AWS Provider
provider "aws" {
  region     = var.region
  access_key = var.access_key #从变量文件中获取的值
  secret_key = var.secret_key
}

# Create SSH key
module "rsakey" {
  source     = "./modules/rsakey"
  pemname    = "demo.pem"
  awskeyname = "aws_key"
}

# Create VPC
module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_name = "aws-mqtt"
}

# Create Instance
# Default username/password   (admin/public)
module "server" {
  source          = "./modules/server"
  ami             = var.ami
  name            = "mqtt"
  key_name        = module.rsakey.public_key_name
  private_key     = module.rsakey.private_key_pem
  subnet_id       = module.vpc.public_subnet_id
  security_groups = module.vpc.security_group_id
}
