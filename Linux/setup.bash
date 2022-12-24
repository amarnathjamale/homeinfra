#!/bin/bash

# Update dot files
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Update the all packages
yum update -y

# Install Ansible event driven ansible
yum install python3-pip -y
pip install ansible
ansible-galaxy collection install ansible.eda
ansible-playbook -i localhost, -c local ansible.eda.install_rulebook_cli

# Run Ansible Playbook for Home Infra