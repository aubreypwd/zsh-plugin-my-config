#!/bin/zsh

###
 # Misc Stuff
 #
 # @since Wednesday, June 29, 2022
 ##

if [[ $(pwd) == "$HOME" ]]; then

	touch "$HOME/.hushlogin" # Don't show last login message, e.g. you have mail, etc.

	###
	 # Hidden/Unhidden Files & Folders
	 #
	 # @TODO Make hide and show a zsh plugin so this is easier.
	 #
	 # @since Thursday, 10/1/2020
	 ##
	chflags hidden "$HOME/Applications"
	chflags nohidden "$HOME/Library"
	chflags nohidden "$HOME/Documents"
	chflags hidden "$HOME/Desktop"
	chflags hidden "$HOME/Music"
	chflags hidden "$HOME/Public"
	chflags nohidden "$HOME/Sites/Local"
	chflags hidden "$HOME/Applications (Parallels)"

	# Make sure keys and identities make it into keychain.
	ssh-add -q --apple-load-keychain -k

	# Directories I want to exist.
	mkdir -p "$HOME/Pictures/Screenshots"
fi