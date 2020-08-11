# Install WP-CLI to manage WordPress sites

echo "Installing WP-CLI for WordPress management"

echo ''

sudo wget --no-check-certificate -O wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 

sudo chmod +x wp-cli.phar 

sudo mv wp-cli.phar /usr/local/bin/wp  

		

sudo wp theme install phlox  --activate --allow-root

sudo wp plugin install wordpress-seo --activate --allow-root

sudo wp plugin install cookie-notice --activate --allow-root
