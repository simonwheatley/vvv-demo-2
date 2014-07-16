# Init script for VVV Auto Bootstrap Demo 2

echo "Commencing VVV Demo 2 Setup"

# Make a database, if we don't already have one
echo "Creating database (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS vvv_demo_2"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON vvv_demo_2.* TO wp@localhost IDENTIFIED BY 'wp';"

# Run Composer
composer install --prefer-dist

# Download WordPress
if [ ! -f htdocs/wp-config.php ]
then
	echo "Creating wp-config.php and installing WordPress"
	wp core config --dbname="vvv_demo_2" --dbuser=wp --dbpass=wp --dbhost="localhost" --extra-php <<PHP
define( 'WP_CONTENT_DIR', dirname(__FILE__) . '/wp-content/' );
define( 'WP_SITEURL',     'http://vvv-demo-2.dev/wordpress/');
PHP
	mv htdocs/wordpress/wp-config.php htdocs/
	wp core install --url=vvv-demo-2.dev --title="VVV Bootstrap Demo 2" --admin_user=admin --admin_password=password --admin_email=demo@example.com
fi

# The Vagrant site setup script will restart Nginx for us

echo "VVV Demo 2 site now installed";

