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

	# Don't use exa outside of Terminus
	alias ls='ls -lah --color' # Use normal alias
else

	# Use exa outside of Terminus.
	alias ls='exa -l -g --icons --tree --level=1 -a --group-directories-first' # Enhance exa ls defaults.
	alias ll='exa -l -g --icons --tree --level=2 -a --group-directories-first' # Enhance exa ls defaults, but show 2 levels deep.
fi
