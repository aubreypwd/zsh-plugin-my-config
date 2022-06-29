#!/bin/zsh

###
 # Misc Stuff
 #
 # @since Wednesday, June 29, 2022
 ##

# Quietly, and in the background...
() {

	touch "$HOME/.hushlogin" # Don't show last login message, e.g. you have mail, etc.

	###
	 # Terminus for Sublime Text 3 Support
	 #
	 # @TODO Convert to own plugin.
	 #
	 # @since Monday, 9/21/2020
	 ##
	if [ "$TERM_PROGRAM" = "Terminus-Sublime" ]; then

		# Fix arrow keys.
		bindkey "\e[1;3C" forward-word
		bindkey "\e[1;3D" backward-word

		# Don't use exa outside of Terminus
		alias ls='ls -lah --color' # Use normal alias
	else

		# Use exa outside of Terminus.
		alias ls='exa -l -g --icons --tree --level=1 -a' # Enhance exa ls defaults.
		alias ll='exa -l -g --icons --tree --level=2 -a' # Enhance exa ls defaults, but show 2 levels deep.

	fi

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

} &> /dev/null &
