#!/bin/bash

###
 # Instruct someone to use a different command.
 #
 # @since Wednesday, July 27, 2022
 ##
useinstead() {

	echo "Use [$1] instead, this command has been deprecated."
	return 1
}


###
 # Aliases
 ##
alias valet@7="echo 'From within a site directory, use [valet isolate php@7.x] instead.' && (exit 3)"
alias valet@8="echo 'From within a site directory, use [valet isolate php@8.x] instead.' && (exit 3)"
alias valetv="echo 'No alternative.' && (exit 33)" # A way to see what version valet is running at.
alias valets="echo 'localtunnel is unreliable, use [valet share] instead' && (exit 3)" # valet share, but just with localtunnel.

###
 # Functions
 ##
vu() { useinstead "valet isolate php@x.x"; }
watchf() { useinstead "watchfext"; }