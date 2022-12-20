output "public_subnet_id" {
  description = "AWS public_subnet"
  value       = aws_subnet.vpc_pubsubnet.id
}

output "security_group_id" {
  description = "AWS public_subnet"
  value       = aws_security_group.vpc_sgp.id
}