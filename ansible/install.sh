#!/bin/bash

sudo apt update && sleep 5;

#!/bin/bash

sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
sleep 3;
echo "ansible installed"

echo "running playbook"
ansible-playbook -u ubuntu /home/ubuntu/setup-jenkins.yml -vvv