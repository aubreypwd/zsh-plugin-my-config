#!/bin/sh

###
 # Sublime configurations.
 #
 # @since Jan 16, 2023
 # @since Sep 14, 2023 No longer setting sublime to the default app, using OpenIn 4.
 ##

( ( # Quietly run in the background...

	# Keep sublime associated with these extensions.
	# for ext in php js json yml md sh zsh html; do
		# duti -s "osascript -e 'id of app \"Sublime Text\"'" ".$ext" all
	# done

) 1>&- 2>&- & )
