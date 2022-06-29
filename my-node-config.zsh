#!/bin/zsh

###
 # Misc Stuff
 #
 # @since Wednesday, June 29, 2022
 ##

# Quietly, and in the background...
() {

	npm config --location=global set git-tag-version true || npm -g config set git-tag-version true

} &> /dev/null &
