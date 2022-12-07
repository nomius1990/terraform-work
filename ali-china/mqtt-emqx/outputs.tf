output "vpc_id" {
  value = "VPC_ID = ${module.mqtt_vpc.vpc_id}"
}

output "emqx_address" {
  description = "public ip of the emqx,username = admin,password = public"
  value       = "http://${module.mqtt_emqx.public_ip}:18083"
}