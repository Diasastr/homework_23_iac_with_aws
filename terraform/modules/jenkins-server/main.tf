/* Jenkins Controller */
// Ресурс EC2 інстансу для Jenkins контролера. Використовує останній AMI Ubuntu.
resource "aws_instance" "jenkins_controller" {
  ami                    = data.aws_ami.ubuntu.id // ID останнього AMI Ubuntu.
  instance_type          = var.instance_type // Тип інстансу, визначений у змінній.
  subnet_id              = element(var.public_subnet_ids, 0) // Підмережа для розміщення інстансу.
  key_name               = var.key_name // Назва ключа EC2 для доступу.
  vpc_security_group_ids = [var.jenkins_security_group_id] // ID групи безпеки Jenkins.

  iam_instance_profile = var.jenkins_instance_profile_name

  tags = {
    Name        = "${var.environment}-jenkins-controller"
    Environment = var.environment
    Role        = "jenkins"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "echo 'Wait for SSH'"
    ]
  }

  provisioner "file" {
    source      = "./ansible/install.sh"
    destination = "/home/ubuntu/install.sh"
  }

  provisioner "file" {
    source      = "./ansible/playbooks/setup-jenkins.yml"
    destination = "/home/ubuntu/setup-jenkins.yml"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/install.sh",
      "/home/ubuntu/install.sh",
    ]
  }
}



