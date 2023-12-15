#!/bin/zsh

###
 # MySQL Configurations
 #
 # @since Jan 16, 2023
 ##

startup-mysql () {

	# Fix issue where PHP 8.1 can't access the WordPress DB.
	mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';"
}

