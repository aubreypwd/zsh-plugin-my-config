#!/bin/bash

###
 # ls Configuration
 #
 # @since Wednesday, June 29, 2022
 ##
if [ "$TERM_PROGRAM" = "Terminus-Sublime" ]; then

	# Fix arrow keys.
	bindkey "\e[1;3C" forward-word
	bindkey "\e[1;3D" backward-word

	# Don't use eza outside of Terminus
	alias ls='ls -lah --color' # Use normal alias
else

	# Use eza outside of Terminus.
	alias ls='eza -l -g --icons --tree --level=1 -a --group-directories-first' # Enhance eza ls defaults.
	alias ll='eza -l -g --icons --tree --level=2 -a --group-directories-first' # Enhance eza ls defaults, but show 2 levels deep.
fi
