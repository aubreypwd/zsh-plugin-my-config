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
 # False (an error).
 #
 # @since Wednesday, July 27, 2022
 # @since Oct 13, 2022             Renamed to return_true.
##
__return_false () {
	return 1
}

###
 # True (no error).
 #
 # @since Wednesday, July 27, 2022
 # @since Oct 13, 2022             Renamed to return_false.
##
__return_true () {
	return 0
}