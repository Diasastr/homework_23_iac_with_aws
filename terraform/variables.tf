/* Змінна для визначення регіону. */
variable "region" {
  description = "AWS регіон"
  default = "eu-north-1"
}

/* Змінна для визначення CIDR блоку VPC. */
variable "vpc_cidr" {
  description = "CIDR блок для VPC."
  type        = string
}

/* Список CIDR блоків для публічних підмереж. */
variable "public_subnets_cidr" {
  description = "Список CIDR блоків для публічних підмереж."
  type        = list(string)
}

/* Список CIDR блоків для приватних підмереж. */
variable "private_subnets_cidr" {
  description = "Список CIDR блоків для приватних підмереж."
  type        = list(string)
}

/* Змінна для визначення середовища розгортання (наприклад, dev, staging, prod). */
variable "environment" {
  description = "Середовище розгортання (наприклад, dev, staging, prod)."
  type        = string
}

/* CIDR блоки для доступу до інстансів через SSH. */
variable "instance_connect_ssh_cidr" {
  description = "CIDR блоки для доступу SSH до інстансів."
  type        = list(string)
  default     = ["13.48.4.200/30"]
}

/* Шлях до публічного ключа для використання з парою ключів 'deployer'. */
variable "public_key_path" {
  description = "Шлях до публічного ключа для пари ключів 'deployer'."
  type        = string
  default     = "modules/security/deployer-key.pub"
}

/* Список зон доступності у регіоні. */
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  availability_zones = data.aws_availability_zones.available.names
  // Значення за замовчуванням відсутнє, оскільки воно буде динамічно визначено
}

/* Тип EC2 інстансу, який буде використовуватися для серверів. */
variable "instance_type" {
  description = "Тип EC2 інстансу."
  type        = string
  default     = "t3.small" // Можете змінити на інший тип за потребою.
}

/* Назва SSH ключа для доступу до EC2 інстансів. */
variable "key_name" {
  description = "Назва ключа EC2, що використовується для доступу до інстансів."
  type        = string
  // Значення за замовчуванням не встановлено, оскільки ключ має бути визначено користувачем.
}

variable "private_key_path" {
  description = "Path to the SSH private key"
}

