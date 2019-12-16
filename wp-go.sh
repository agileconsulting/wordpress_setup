#!/bin/bash

#########################################################
#                                                       #
#       Package Name: Lamp                              #
#       Author:Marco Baraldiam                          #
#       Description: LampPack allows you to             #
#       automate the installation of LAMP stack         #
#       and many other utilities on Ubuntu              #
#                                                       #
#########################################################

source ./passwd.sh
directoryName="/var/www/$domainname"


#Configure apache
sudo mkdir $directoryName
sudo echo "<VirtualHost *:80>
	ServerName $domainname
	DocumentRoot \"$directoryName/\"
	<Directory \"$directoryName\">
		Options FollowSymLinks
		AllowOverride All
		Order allow,deny
		Allow from all
	</Directory>
</VirtualHost>" > /etc/apache2/sites-available/$domainname.conf

sudo a2ensite $domainname 

# Create database and database user for WordPress
mysql -u root -p$MYSQL_ROOT_PASSWORD<<EOF
CREATE USER '$WP_DB_USERNAME'@'localhost' IDENTIFIED BY '$WP_DB_PASSWORD';
CREATE DATABASE $WP_DB_NAME;
GRANT ALL ON $WP_DB_NAME.* TO '$WP_DB_USERNAME'@'localhost';
alter user '$WP_DB_USERNAME'@'localhost' identified with mysql_native_password by '$WP_DB_PASSWORD';
FLUSH PRIVILEGES;
EOF

cd $directoryName

sudo wp core download --allow-root 
sudo wp config create --dbname=$WP_DB_NAME --dbuser=$WP_DB_USERNAME --dbpass=$WP_DB_PASSWORD --allow-root 
sudo wp core install --allow-root --url="$domainname" --title="$sitetitle" --admin_user="$siteuser" --admin_password="$sitepassword" --admin_email="$siteemail"   --skip-email
cp ./php.ini /etc/php/7.3/apache2/php.ini
sudo chown -R www-data:www-data $directoryName 
