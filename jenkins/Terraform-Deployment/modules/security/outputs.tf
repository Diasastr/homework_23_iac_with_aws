/*
  Визначення вихідних змінних для модуля безпеки.
  Надає доступ до ключової інформації про створені групи безпеки та пару ключів.
*/

output "default_security_group_id" {
  description = "ID групи безпеки за замовчуванням."
  value       = aws_security_group.default.id
}

output "app_server_security_group_id" {
  description = "ID групи безпеки для серверів додатків."
  value       = aws_security_group.app_server_sg.id
}

output "key_name" {
  description = "Назва пари ключів 'deployer'."
  value       = aws_key_pair.deployer.key_name
}

output "private_key" {
  value     = tls_private_key.private_key.private_key_pem
  sensitive = true
}