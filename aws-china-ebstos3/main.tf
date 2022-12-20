# Create SSH key
module "rsakey" {
  source     = "./modules/rsakey"
  pemname    = "aws.pem"
  awskeyname = "aws_key"
}

# Create VPC
module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_name = "aws-mqtt"
}

module "server-s3" {
  source          = "./modules/server-s3"
  ami             = var.ami
  name            = "mqtt-backup"
  filename        = "20221220-backup"
  s3-bucket       = var.s3-bucket
  volume_id       = var.volume_id
  key_name        = module.rsakey.public_key_name
  private_key     = module.rsakey.private_key_pem
  subnet_id       = module.vpc.public_subnet_id
  security_groups = module.vpc.security_group_id
  access_key      = var.access_key
  secret_key      = var.secret_key
  region          = var.region
}