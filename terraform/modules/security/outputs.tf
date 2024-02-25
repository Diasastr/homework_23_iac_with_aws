/*
  Визначення вихідних змінних для модуля безпеки.
  Надає доступ до ключової інформації про створені групи безпеки та пару ключів.
*/

output "default_security_group_id" {
  description = "ID групи безпеки за замовчуванням."
  value       = aws_security_group.default.id
}

output "jenkins_security_group_id" {
  description = "ID групи безпеки для Jenkins."
  value       = aws_security_group.jenkins_sg.id
}

output "key_name" {
  description = "Назва пари ключів 'deployer'."
  value       = aws_key_pair.deployer.key_name
}

output "jenkins_iam_role_arn" {
  value = aws_iam_role.jenkins_role.arn
  description = "The ARN of the IAM role assigned to the Jenkins instance."
}

output "jenkins_instance_profile_name" {
  value = aws_iam_instance_profile.jenkins_instance_profile.name
  description = "The name of the IAM instance profile assigned to the Jenkins instance."
}