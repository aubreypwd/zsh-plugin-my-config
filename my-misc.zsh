#!/bin/bash

###
 # Misc Stuff
 #
 # @since Wednesday, June 29, 2022
 ##
startup-misc () {

	upgrade
	cleanup
	brewd

	antigen update

	mkdir -p "$HOME/Pictures/Screenshots"
	mkdir -p "$HOME/Pictures/Screenshots/Autosaved" # Where we put CleanshotX.

	# Make sure keys and identities make it into keychain.
	ssh-add -q --apple-load-keychain -k

	if [[ $(pwd) != "$HOME" ]]; then
		return # Don't do the below unless we're loading the HOME folder.
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
	chflags nohidden "$HOME/Applications"
	chflags hidden "$HOME/Desktop"
	chflags hidden "$HOME/Documents"
	chflags hidden "$HOME/Public"
	chflags nohidden "$HOME/Library"
	chflags hidden "$HOME/aportwood@awesomemotive.com - Google Drive"
	chflags hidden "$HOME/aubreypwd@gmail.com - Google Drive"
}

# Automatically choose suggestion in zsh-autosuggestions using TAB.
bindkey '^[[Z' autosuggest-accept
