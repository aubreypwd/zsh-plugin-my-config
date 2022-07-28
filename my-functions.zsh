#!/bin/bash

###
 # Functions
 #
 # Note, these are here because these aren't intended to act as
 # commands, but rather global functions we can use in other
 # functions intended to be commands.
 #
 # @since Thursday, July 28, 2022
 ##

###
 # Switch database and import a DB file.
 #
 # @since Thursday, July 28, 2022
 ##
__affwp_sdbi () {

	test -e "$2" || return 1 # Does the zip file exist?
	wpdbs "$(nwd)@$1" || true # Pass no matter what, switching might fail due to wp option get home.
	wp db create || true # Also pass, the DB may already exist.
	wpdbi "$2" || return 1 # Import the DB into the new database.

	wp option set blogname "$(wpdbn)" # Rename the site title to the DB name, so it's easlier to see.

	return 0
}