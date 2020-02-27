# wordpress cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# craete database
DB="wordpress"
USER="root"
PASS="root"

sudo mysql -hlocalhost -uroot -proot -e "CREATE DATABASE $DB CHARACTER SET utf8 COLLATE utf8_general_ci";
# sudo mysql -hlocalhost -uroot -proot -e "CREATE USER $USER@'localhost' IDENTIFIED BY '$PASS'";
# sudo mysql -hlocalhost -uroot -proot -e "GRANT SELECT, INSERT, UPDATE ON $DB.* TO '$USER'@'localhost'";

# install wordpress
cd /var/www/example.com/public_html
wp core download
wp core config --dbhost=localhost --dbname=wordpress --dbuser=root --dbpass=root
wp core install --url=www.example.com --title="Example Site" --admin_name=wp_admin --admin_password=password --admin_email=you@domain.com