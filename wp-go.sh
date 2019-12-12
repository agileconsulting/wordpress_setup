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
directoryName="/var/www/$domainName"


#Configure apache
sudo mkdir $directoryName
sudo echo "<VirtualHost *:80>
	ServerName $domainName
	DocumentRoot \"$directoryName/\"
	<Directory \"$directoryName\">
		Options FollowSymLinks
		AllowOverride All
		Order allow,deny
		Allow from all
	</Directory>
</VirtualHost>" > /etc/apache2/sites-available/$domainName.conf

sudo a2ensite $domainName 
sudo chmod -R $directoryName 
sudo chown -R www-data:www-data $directoryName 




# Create database and database user for WordPress
mysql -u root -p$MYSQL_ROOT_PASSWORD <<EOF
CREATE DATABASE  $dbname;
CREATE USER '$dbusername'@'localhost' IDENTIFIED BY '$dbpassword';
GRANT ALL PRIVILEGES ON *.* TO '$dbusername'@'localhost';
FLUSH PRIVILEGES;
EOF

cd $directoryNamE

sudo wp core download --allow-root 
sudo wp core config --dbname=$dbname --dbuser=$dbusername --dbpass=$dbpassword --allow-root 
sudo wp core install --allow-root --url="$domainname" --title="$sitetitle" --admin_user="$siteuser" --admin_password="$sitepassword" --admin_email="$siteemail"

