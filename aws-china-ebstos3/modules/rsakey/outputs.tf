output "public_key_name" {
  value = aws_key_pair.awspubkey.key_name
}

output "private_key_pem" {
  value = tls_private_key.prikey.private_key_pem
}