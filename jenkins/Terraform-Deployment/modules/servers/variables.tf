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

data "aws_ami" "latest_amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["amazon"] # Amazon Linux 2 AMI owner
}

variable "key_name" {
  description = "Назва пари ключів 'deployer'."
  type        = string
  default     = "deployer-key-jenkins"
}
