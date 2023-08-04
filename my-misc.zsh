#!/bin/bash

###
 # Misc Stuff
 #
 # @since Wednesday, June 29, 2022
 ##

( (

	# Directories I want to exist.
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

) 1>&- 2>&- & )

# Automatically choose suggestion in zsh-autosuggestions using TAB.
bindkey '^[[Z' autosuggest-accept

# Make sure all the PHP versions have config files symlinked.
( (

	if [[ $(pwd) != "$HOME" ]]; then
		return # Don't do the below unless we're loading the HOME folder.
	fi

	php_versions=(7.3 7.4 8.0 8.1 8.2)
	files=( 'php.ini' 'xdebug-3.ini' )

	for version in "${php_versions[@]}"; do
		for file in "${files[@]}"; do
			ln -sf "$HOME/Sites/conf.d/$file" "/opt/homebrew/etc/php/$version/conf.d/z-$file"
		done
	done
) 1>&- 2>&- & )