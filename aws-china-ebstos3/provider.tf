# Configure the AWS Provider
provider "aws" {
  region     = var.region
  access_key = var.access_key #从变量文件中获取的值
  secret_key = var.secret_key
}