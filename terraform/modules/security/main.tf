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

/*==== Група Безпеки Jenkins ======*/
// Група безпеки для Jenkins, що дозволяє веб-доступ та обмежений SSH.
resource "aws_security_group" "jenkins_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "$jenkins-server-sg"
    Environment = var.environment
    Role        = "jenkins"
  }
}

/*==== Пара Ключів для Розгортання ======*/
// Пара ключів для операцій розгортання, що дозволяє безпечний доступ SSH.
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key-${var.environment}"
  public_key = file("${path.module}/deployer-key.pub")
}

# IAM ROLE
resource "aws_iam_role" "jenkins_role" {
      name = "jenkins_role"

      assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Sid    = ""
            Principal = {
              Service = "ec2.amazonaws.com"
            }
          },
        ]
      })
    }

# attached aws ec2 policy is attached

resource "aws_iam_role_policy_attachment" "ec2full_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role       = aws_iam_role.jenkins_role.name
}


# attached aws ecr policy is attached

resource "aws_iam_role_policy_attachment" "ecr_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  role       = aws_iam_role.jenkins_role.name

}

# attached aws vpc policy is attached

resource "aws_iam_role_policy_attachment" "vpc_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
  role       =  aws_iam_role.jenkins_role.name


  }

# attached aws iam policy is attached

resource "aws_iam_role_policy_attachment" "iam_policy" {
  policy_arn =  "arn:aws:iam::aws:policy/IAMFullAccess"
  role       =  aws_iam_role.jenkins_role.name
  }

resource "aws_iam_instance_profile" "jenkins_instance_profile" {
  name  = "jenkins_instance_profile"
  role = aws_iam_role.jenkins_role.name
}
