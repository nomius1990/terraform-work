
# \
/*
    1 VPC 
    1 subnet
    1 security group
    1 Internet Gateway
    1 Route Table
*/
variable  vpc_cidr {}
variable  vpc_name {}
data "aws_availability_zones" "aws_avazones" {}

# Virtual Private Cloud 
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = var.vpc_name
    Environment = "demo_environment"
    Terraform   = "true"
  }
}

# public subbet
resource "aws_subnet" "vpc_pubsubnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 100)
  availability_zone       = tolist(data.aws_availability_zones.aws_avazones.names)[0]
  map_public_ip_on_launch = true
  tags = {
    Name      = "demo public subnet"
    Terraform = "true"
  }
}

# security group
resource "aws_security_group" "vpc_sgp" {
  name        = "vpc_sgp"
  vpc_id      = aws_vpc.vpc.id
  description = "website service"

   ingress {
    description = "Allow Port mqtt"
    from_port   = 18083
    to_port     = 18083
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = "Allow Port mqtt"
    from_port   = 1883
    to_port     = 1883
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "open VPN"
    from_port   = 1194
    to_port     = 1194
    protocol    = "UDP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow SSH"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }
  lifecycle {
    create_before_destroy = true 
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw from terraform"
  }
}

resource "aws_default_route_table" "example" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "connect gateway default"
  }
}

output "public_subnet_id" {
  description = "AWS public_subnet"
  value       = aws_subnet.vpc_pubsubnet.id
}

output "security_group_id" {
  description = "AWS public_subnet"
  value       = aws_security_group.vpc_sgp.id
}