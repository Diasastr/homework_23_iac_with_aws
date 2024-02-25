/*
  Визначення вхідних змінних для модуля безпеки.
  Дозволяє налаштувати параметри груп безпеки та пар ключів залежно від середовища.
*/

variable "vpc_id" {
  description = "ID VPC, де будуть створені групи безпеки."
  type        = string
}

variable "environment" {
  description = "Назва середовища, яке використовується для тегування ресурсів."
  type        = string
}

variable "instance_connect_ssh_cidr" {
  description = "CIDR блоки для доступу до Jenkins через SSH."
  type        = list(string)
  default     = ["13.48.4.200/30"]
}

variable "public_key_path" {
  description = "Шлях до публічного ключа для пари ключів 'deployer'."
  type        = string
  default     = "modules/security/deployer-key.pub"
}
