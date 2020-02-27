#!/usr/bin/env bash
sudo su

# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='root'

# set environment language
echo LC_ALL="en_US.UTF-8" >> /etc/environment
# export LANGUAGE=en_US.UTF-8
# export LC_ALL=en_US.UTF-8
# export LANG=en_US.UTF-8
# export LC_TYPE=en_US.UTF-8

# install apache 2.5 and php 7.2
apt-get install -y apache2

# update / upgrade
add-apt-repository -y ppa:ondrej/php
apt-get update

# install PHP
apt-get install -y php7.2
apt-get install -y php7.2-fpm
apt-get install -y php7.2-cgi
apt-get install -y php7.2-cli
apt-get install -y php7.2-common
apt-get install -y php7.2-curl
apt-get install -y php7.2-gd
apt-get install -y php7.2-json
apt-get install -y php7.2-intl
apt-get install -y php7.2-mbstring
apt-get install -y php7.2-pgsql
apt-get install -y php7.2-phpdbg
apt-get install -y php7.2-xml
apt-get install -y php7.2-zip
apt-get install -y php7.2-soap

# install mysql and give password to installer
debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
apt-get install -y mysql-server
apt-get install -y php7.2-mysql

# install phpmyadmin and give password(s) to installer
# for simplicity I'm using the same password for mysql and phpmyadmin
debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
apt-get install -y phpmyadmin

# restart apache
service apache2 restart

# enable mod_rewrite
a2enmod rewrite

# setup hosts file
sudo cp /vagrant/sites/* /etc/apache2/sites-available
# VHOST=$(cat <<EOF
# <VirtualHost *:80>
#     DocumentRoot "/var/www/html/${PROJECTFOLDER}"
#     <Directory "/var/www/html/${PROJECTFOLDER}">
#         AllowOverride All
#         Require all granted
#     </Directory>
# </VirtualHost>
# EOF
# )
# echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

# install Composer
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Restart Service and Mysql
service apache2 restart
service mysql restart

# exit sudo su
exit