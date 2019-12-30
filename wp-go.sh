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
sudo echo "<VirtualHost www.$domainname:80>
        ServerName www.$domainname
        DocumentRoot \"$directoryName/\"
        <Directory \"$directoryName\">
                Options FollowSymLinks
                AllowOverride All
                Order allow,deny
                Allow from all
        </Directory>
</VirtualHost>" > /etc/apache2/sites-available/www.$domainname.conf

sudo a2ensite www.$domainname

sudo echo "<VirtualHost $domainname:80>
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
sudo wp core install --allow-root --url="$domainname" --title="$sitetitle" --admin_user="$siteuser" --admin_password="$sitepassword" --admin_email="$WP_ADMIN_EMAIL"  --skip-email

sudo wp theme install phlox  --activate --allow-root
sudo wp plugin install wordpress-seo --activate --allow-root
sudo wp plugin install cookie-notice --activate --allow-root

sudo chown -R www-data:www-data $directoryName 

#Change asap
cd ..
sudo chmod -R  777 *


sudo systemctl restart apache2

#To setup https sostituisci con il domain name. farlo a mano Segui https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-ubuntu-18-04
#sudo certbot --apache -d financial-independence.tk -d www.financial-independence.tk




