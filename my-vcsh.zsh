#!/bin/zsh

###
 # Node configurations
 #
 # @since Wednesday, June 29, 2022
 ##

###
 # Quietly, and in the background...
 ##
() {

	###
	 # vcsh Repos
	 #
	 # @since Wednesday, April 20, 2022
	 ##
	vcsh write-gitignore pub # Ignore files by default.
	vcsh write-gitignore priv # Ignore files by default.

} &> /dev/null &