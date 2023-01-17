#!/bin/zsh

###
 # Sublime configurations.
 #
 # @since Jan 16, 2023
 ##

( (

	# Keep sublime associated with these extensions.
	for ext in php js json yml md sh zsh html; do
		duti -s "osascript -e 'id of app \"Sublime Text\"'" ".$ext" all
	done

) 1>&- 2>&- & )
