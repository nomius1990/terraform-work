
output "clb_public_ip" {
  description = "The public ip of clb"
  value       = alicloud_slb_load_balancer.clb.address
}

output "clb_id" {
  description = "clb id"
  value       = alicloud_slb_load_balancer.clb.id
}