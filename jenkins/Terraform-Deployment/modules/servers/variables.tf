/*
  Визначення вхідних змінних для модуля серверів.
  Дозволяє гнучке налаштування типів інстансів та інших параметрів.
*/

variable "instance_type" {
  description = "Тип EC2 інстансу."
  type        = string
  default     = "t3.small"
}

variable "environment" {
  description = "Назва середовища для тегування і назв ресурсів."
  type        = string
}

variable "public_subnet_ids" {
  description = "Список ID публічних підмереж для розміщення інстансів."
  type        = list(string)
}

variable "app_server_security_group_id" {
  description = "ID групи безпеки для сервера додатків."
  type        = string
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

variable "key_name" {
  description = "Назва пари ключів 'deployer'."
  type        = string
  default     = "deployer-key-jenkins"
}
