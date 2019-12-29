#!/bin/bash

#########################################################
#							#
#	Package Name: Lamp				#
#	Author:Marco elvenexian                 	#
#	Description: LampPack allows you to		#
#	automate the installation of LAMP stack		#
# 	and many other utilities on Ubuntu 		#
#							#
#########################################################

echo ''
echo -e "\e[32mWelcome to  LAMP automation bash script\e[39m"
echo ''
sleep 1

echo ''


# Check if is root or not
if [ "$EUID" -ne 0 ]
  then
  	echo -e "\e[31mError! You must run this as root user\e[39m"
  exit
fi

# Install sudo if missing
if ! hash sudo 2>/dev/null; then
	apt-get update -y 
	apt-get install sudo
	exit
fi

		#Read all password
                source ./passwd.sh
		
		#Add to instal phpadmin
		sudo add-apt-repository ppa:phpmyadmin/ppa

		# Run an update and upgrade for packages
		echo "Checking for available software updates"
		echo ''
		sudo apt-get update -y 
		
		echo "Applying critical updates"
		echo ''
		sudo apt-get upgrade -y  

		# Install essential dependencies
		echo "Installing essential dependencies"
		echo ''
		sudo apt-get install -y build-essential  

		
		# Install ZIP
		sudo apt-get -y install zip  

		# Setup Firewall & Allow SSH
		apt-get install ufw
		ufw enable
		ufw allow ssh
		ufw allow http
		ufw allow https 

		#Install usefull tools
	        sudo apt-get -y install net-tools
        	sudo apt-get -y install git
        	sudo apt-get -y install openssh-server
	
		# Install sendmail
		echo "Installing sendmail"
		echo ''
		sudo apt-get -y install sendmail  

		# Install AMP 
		echo "Installing LAMP server "
		echo ''


                # sudo apt-get -y install apache2 apache2-utils 
                # sudo systemctl enable apache2
                # sudo systemctl start apache2

		#setup  mysql password
                echo "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD" | sudo debconf-set-selections
                echo "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" | sudo debconf-set-selections		
		
		# Install AMP
		sudo apt-get -y install lamp-server^   
		#sudo apt-get -y install mysql-server



		# Install PHP modules
		sudo apt-get -y install php libapache2-mod-php php-mysql
		sudo apt-get -y install php-mcrypt php-zip php-mbstring 
		sudo apt-get -y install php-cli php-gettext PHP-FPM
		sudo apt-get -y install php-curl php-gd php-xml php-xmlrpc php-soap php-intl
		
		# so I can test phpadmin 
 # so I can test phpadmin
                mysql -u root -p$MYSQL_ROOT_PASSWORD<<EOF
                alter user 'root'@'localhost' identified with mysql_native_password by '$MYSQL_ROOT_PASSWORD';
                FLUSH PRIVILEGES;
EOF
		
		# Install phpmyadmin
		sudo apt-get -y install phpmyadmin
 
		# Enabling modules
		echo "Enabling Apache modules"
		echo ''
		sudo a2enmod rewrite  
   
	
		# Install WP-CLI to manage WordPress sites
		echo "Installing WP-CLI for WordPress management"
		echo ''
		sudo wget --no-check-certificate -O wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
		sudo chmod +x wp-cli.phar 
		sudo mv wp-cli.phar /usr/local/bin/wp  



		
		# Delete apache default conf
		sudo rm /etc/apache2/sites-available/* 
		sudo rm /etc/apache2/sites-enabled/* 
		
		# Restart Apache
		echo -e "\e[33mReloading and restarting Apache server\e[39m"
		echo ''
		sudo service apache2 reload 
		sudo service apache2 restart  

		# Enable auto upgrades
		echo "Enabling automatic software updates"
		echo ''
		sudo apt-get install -y unattended-upgrades  
		sudo dpkg-reconfigure -p critical unattended-upgrades  
		sudo service apache2 restart  

		# Clean junk
		echo -e "\e[33mCleaning junk and completing the installation\e[39m"
		echo ''
		sudo apt-get -y autoremove  
		sudo chmod -R 0755 /var/www
		sudo chown -R www-data:www-data /var/www 


		echo -e "\e[32mInstallation completed!\e[39m"
		echo ''
      
