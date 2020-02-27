#!/usr/bin/env bash

# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='root'

# set environment language
echo LC_ALL='en_US.UTF-8' >> /etc/environment

# update / upgrade
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update

# install apache 2.5 and php 5.5
sudo apt-get install -y apache2

# install PHP
sudo apt-get install -y php7.2

# PHP mod
sudo apt-get install -y php7.2-fpm
sudo apt-get install -y php7.2-cgi
sudo apt-get install -y php7.2-cli
sudo apt-get install -y php7.2-common
sudo apt-get install -y php7.2-curl
sudo apt-get install -y php7.2-gd
sudo apt-get install -y php7.2-json
sudo apt-get install -y php7.2-intl
sudo apt-get install -y php7.2-mbstring
sudo apt-get install -y php7.2-pgsql
sudo apt-get install -y php7.2-phpdbg
sudo apt-get install -y php7.2-xml
sudo apt-get install -y php7.2-zip
sudo apt-get install -y php7.2-soap

# apache mod
sudo apt-get install -y libapache2-mod-php7.2

# restart apache
sudo service apache2 restart

# install mysql and give password to installer
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
sudo apt-get install -y mysql-server
sudo apt-get install -y php7.2-mysql

# install phpmyadmin and give password(s) to installer
# for simplicity I'm using the same password for mysql and phpmyadmin
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo apt-get install -y phpmyadmin
sudo apt-get install -y php-mbstring
sudo apt-get install -y php-gettext

# restart apache2
sudo service apache2 restart

# apache2 conf
sudo a2enmod rewrite

# setup hosts file
sudo cp /vagrant/sites/* /etc/apache2/sites-available

sudo a2ensite default.local.conf
sudo service apache2 reload

sudo a2ensite example.com.conf
sudo service apache2 reload

sudo a2dissite 000-default.conf
sudo service apache2 reload

#check hosts file
sudo apachectl configtest
sudo systemctl restart apache2

# install Composer
sudo curl -s https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Restart Service and Mysql
sudo service apache2 restart
sudo service mysql restart
sudo service php7.2-fpm restart