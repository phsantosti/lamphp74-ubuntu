#!/bin/bash

# Atualização do sistema
sudo apt update
sudo apt upgrade -y

# Instalação do Apache2
sudo apt install -y apache2

# Definindo regras de firewall
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow 3306
sudo ufw allow 3307
sudo ufw allow 21
sudo ufw allow 22

# Ativar UFW
sudo ufw enable

# Instalação do MariaDB
sudo apt-get install -y mariadb-server

# Definindo senha do root user do MariaDB
sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '36630013152478963';"

# Permitindo acesso remoto ao MariaDB
sudo sed -i 's/^bind-address\s*=.*$/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Reiniciando o serviço do MariaDB
sudo systemctl restart mariadb

# Criando usuário com acesso total no banco de dados
sudo mysql -u root -p36630013152478963 -e "CREATE USER 'rootApplication'@'%' IDENTIFIED BY '36630013152478963';"
sudo mysql -u root -p36630013152478963 -e "GRANT ALL PRIVILEGES ON *.* TO 'rootApplication'@'%' WITH GRANT OPTION;"
sudo mysql -u root -p36630013152478963 -e "FLUSH PRIVILEGES;"

# Instalação do software-properties-common para adicionar o repositório do PHP
sudo apt install -y software-properties-common

# Adicionando repositório do PHP 7.4
sudo add-apt-repository ppa:ondrej/php -y

# Atualizando novamente para aplicar as mudanças do repositório
sudo apt update

# Instalação do PHP 7.4
sudo apt install -y php7.4

# Instalação das extensões PHP
sudo apt-get install -y php7.4-cli php7.4-json php7.4-common php7.4-mysql php7.4-zip php7.4-gd php7.4-mbstring php7.4-curl php7.4-xml php7.4-bcmath

sudo apt install composer -y

# Remoção de instalações prévias do Certbot
sudo apt-get remove certbot

# Instalação do Certbot via Snap
sudo apt install snapd
sudo snap install --classic certbot

# Criando um link simbólico para o Certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
