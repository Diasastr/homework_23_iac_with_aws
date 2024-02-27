/* Конфігурація Груп Безпеки та Пари Ключів для Інфраструктури Додатків
   Цей модуль налаштовує групи безпеки для доступу за замовчуванням, Jenkins та серверів додатків,
   а також пару ключів для безпечного доступу до інстансів. */

/*==== Група Безпеки за Замовчуванням VPC ======*/
// Група безпеки за замовчуванням для управління вхідним та вихідним трафіком для всього VPC.
resource "aws_security_group" "default" {
  name        = "${var.environment}-default-sg"
  description = "Default security group to alloe ingress/egress traffic for VPC"
  vpc_id      = var.vpc_id
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }
  tags = {
    Environment = var.environment
  }
}


/*==== Група Безпеки Сервера Додатків ======*/
// Визначає групу безпеки для серверів додатків, дозволяючи веб-трафік та SSH з Jenkins.
resource "aws_security_group" "app_server_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.instance_connect_ssh_cidr
    description = "Allow SSH for EC2 Instance Connect"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [data.aws_security_group.jenkins.id]
    description = "Allow SSH with Jenkins Controller"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-app-server-sg"
    Environment = var.environment
    Role        = "application"
  }
}

/*==== Пара Ключів для Розгортання ======*/
// Пара ключів для операцій розгортання, що дозволяє безпечний доступ SSH.
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key-jenkins"
  public_key = tls_private_key.example.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.example.private_key_pem
  filename = "/var/lib/jenkins/deployer-key-jenkins.pem"
}


