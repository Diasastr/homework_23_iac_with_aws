output "vpc_id" {
  description = "ID створеного VPC."
  value       = module.networking.vpc_id
}

output "public_subnets_ids" {
  description = "ID публічних підмереж."
  value       = module.networking.public_subnets_ids
}

output "app_server_ips" {
  description = "Публічна IP адреса інстансу сервера додатків."
  value       = module.servers.app_server_public_ip
}
