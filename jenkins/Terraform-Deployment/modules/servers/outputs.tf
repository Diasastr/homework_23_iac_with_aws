/*
  Визначення вихідних даних для модуля серверів.
  Надає доступ до важливої інформації про створені EC2 інстанси.
*/
// ID сервера додатків
output "app_server_id" {
  description = "ID інстансу сервера додатків."
  value       = aws_instance.app_server.id
}

// Публічна IP адреса сервера додатків
output "app_server_public_ip" {
  description = "Публічна IP адреса інстансу сервера додатків."
  value       = aws_instance.app_server.public_ip
}
