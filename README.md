# vagrant-lamp

- ubuntu xenial

# bootstrap.sh

- update, upgrade
- create a folder inside /var/www/html
- set vhosts sites -> sites-available
- install apache2.4, php 7.2, mysql, phpmyadmin, git and composer
- set mysql phpmyadmin

# add to hosts file
192.168.33.22 default.local www.default.local
192.168.33.22 example.com www.example.com

# fix phpmyadmin warning
$ /usr/share/phpmyadmin/libraries/sql.lib.php
line: 601
|| (count($analyzed_sql_results[‘select_expr’] == 1)

|| (count($analyzed_sql_results[‘select_expr’]) == 1


#fix phpmyadmin
$ /usr/share/phpmyadmin/libraries/plugin_interface.lib.php
line: 532
if ($options != null && count($options) > 0) {

if ($options != null && count((array)$options) > 0) {
