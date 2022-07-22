#!/bin/zsh

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

###
 # Valet use
 #
 # @since Wednesday, July 6, 2022
 # @since	Friday, July 22, 2022 Deprecated
 ##
function vu {
	echo 'Use [valet isolate php@x.x] intead.' && (exit 3);
}