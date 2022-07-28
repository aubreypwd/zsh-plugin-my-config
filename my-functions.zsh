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
 # Is this the AffiliateWP Repository?
 #
 # @since Thursday, July 28, 2022
 ##
isaffwp () {

	if [ ! -e "./affiliate-wp.php" ]; then
		return 1
	fi

	return 0
}
