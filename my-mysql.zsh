#!/bin/zsh

###
 # MySQL Configurations
 #
 # @since Jan 16, 2023
 ##

( ( # Quietly run in the background...

	# Fix issue where PHP 8.1 can't access the WordPress DB.
	mysql-exec "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';"

) 1>&- 2>&- & )