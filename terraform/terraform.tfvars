# Регіон, в якому будуть розгортатися ресурси.
region = "eu-north-1"

# CIDR блок для VPC, що визначає діапазон IP адрес, доступних в мережі.
vpc_cidr = "10.0.0.0/16"

# Список CIDR блоків для публічних підмереж.
# Кожен блок визначає діапазон IP адрес, що будуть використовуватися в кожній публічній підмережі.
public_subnets_cidr = ["10.0.1.0/24"]

# Список CIDR блоків для приватних підмереж. Цей для використання instance connect
# Кожен блок визначає діапазон IP адрес, що будуть використовуватися в кожній приватній підмережі.
private_subnets_cidr = ["10.0.3.0/24"]

# Середовище розгортання, яке може бути використане для розрізнення ресурсів у різних контекстах (наприклад, dev, staging, prod).
environment = "prod"

# Список CIDR блоків, з яких дозволено доступ SSH до інстансів. Цей для використання instance connect.
# Використовується для налаштування правил групи безпеки.
instance_connect_ssh_cidr = ["13.48.4.200/30"]

# Шлях до публічного ключа, який буде використовуватися для інстансів EC2.
# Ключ дозволяє безпечне підключення до інстансів через SSH.
public_key_path = "modules/security/deployer-key.pub" # замініть на свій

private_key_path = "C:\\Users\\streb\\ssh_aws\\ssh_aws"

# Тип EC2 інстансу, який буде використовуватися для розгортання серверів.
instance_type = "t3.small"

# Назва ключа EC2, який використовується для доступу до інстансів.
# Ключ повинен бути попередньо створений у AWS.
key_name = "deployer-key"

