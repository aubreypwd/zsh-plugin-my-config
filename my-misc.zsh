#!/bin/zsh

###
 # Misc Stuff
 #
 # @since Wednesday, June 29, 2022
 ##


() {

	# Directories I want to exist.
	mkdir -p "$HOME/Pictures/Screenshots"

	# Make sure keys and identities make it into keychain.
	ssh-add -q --apple-load-keychain -k

	if [[ $(pwd) != "$HOME" ]]; then
		return
	fi

	touch "$HOME/.hushlogin" # Don't show last login message, e.g. you have mail, etc.

	###
	 # Hidden/Unhidden Files & Folders
	 #
	 # @TODO Make hide and show a zsh plugin so this is easier.
	 #
	 # @since Thursday, 10/1/2020
	 ##
	chflags hidden "$HOME/Applications (Parallels)"
	chflags hidden "$HOME/Applications"
	chflags hidden "$HOME/Desktop"
	chflags hidden "$HOME/Documents"
	chflags hidden "$HOME/Public"
	chflags nohidden "$HOME/Library"

} &> /dev/null &!
