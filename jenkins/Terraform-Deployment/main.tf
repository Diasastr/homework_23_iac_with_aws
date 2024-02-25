/* Модуль мережі */
// Цей модуль налаштовує всю мережеву інфраструктуру, включаючи VPC, публічні та приватні підмережі.
module "networking" {
  source               = "./modules/networking"
  vpc_cidr             = var.vpc_cidr // CIDR блок для VPC.
  public_subnets_cidr  = var.public_subnets_cidr // Список CIDR блоків для публічних підмереж.
  private_subnets_cidr = var.private_subnets_cidr // Список CIDR блоків для приватних підмереж.
  environment          = var.environment // Назва середовища розгортання.
  availability_zones   = local.availability_zones // Список зон доступності, визначений локально.
}

/* Модуль безпеки */
// Налаштовує групи безпеки і ключі доступу для інстансів.
module "security" {
  source                   = "./modules/security"
  vpc_id                   = module.networking.vpc_id // ID VPC, створеного модулем мережі.
  environment              = var.environment
  instance_connect_ssh_cidr = var.instance_connect_ssh_cidr // CIDR блоки для SSH доступу.
}

/* Модуль серверів */
// Створює EC2 інстанси для Jenkins контролера та серверів додатків.
module "servers" {
  source                       = "./modules/servers"
  instance_type                = var.instance_type // Тип EC2 інстансу.
  public_subnet_ids            = module.networking.public_subnets_ids // ID публічних підмереж.
  app_server_security_group_id = module.security.app_server_security_group_id // ID групи безпеки для серверів додатків.
  environment                  = var.environment
  key_name                     = module.security.key_name
}

