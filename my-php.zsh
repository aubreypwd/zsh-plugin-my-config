#!/bin/bash

###
 # PHP Configuration, etc
 #
 # @since Dec 21, 2022
 ##

# Make sure all the PHP versions have config files symlinked.
( (

	php_versions=(7.3 7.4 8.0 8.1 8.2)
	conf_files=( 'php.ini' 'xdebug-3.ini' )

	for version in "${php_versions[@]}"; do
		for conf_file in "${conf_files[@]}"; do
			ln -sf "$HOME/.config/php/conf.d/$conf_file" "/opt/homebrew/etc/php/$version/conf.d/z-$conf_file"
		done
	done

) 1>&- 2>&- & )