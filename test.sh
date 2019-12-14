WP_DOMAIN="wordpress.peteris.rocks"
WP_ADMIN_USERNAME="admin"
WP_ADMIN_PASSWORD="admin"
WP_ADMIN_EMAIL="no@spam.org"
WP_DB_NAME="wordpress"
WP_DB_USERNAME="wordpress"
WP_DB_PASSWORD="wordpress"
MYSQL_ROOT_PASSWORD="root"


echo "mysql-server-5.7 mysql-server/root_password password $MYSQL_ROOT_PASSWORD" | sudo debconf-set-selections
echo "mysql-server-5.7 mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" | sudo debconf-set-selections
sudo apt install -y  php-mysql php-curl php-gd mysql-server


mysql -u root -p$MYSQL_ROOT_PASSWORD <<EOF
CREATE USER '$WP_DB_USERNAME'@'localhost' IDENTIFIED BY '$WP_DB_PASSWORD';
CREATE DATABASE $WP_DB_NAME;
GRANT ALL ON $WP_DB_NAME.* TO '$WP_DB_USERNAME'@'localhost';
EOF
