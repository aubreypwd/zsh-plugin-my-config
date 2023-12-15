#!/bin/sh

###
 # My Prompt
 #
 # @since Apr 6, 2023
 #
 # shellcheck disable=SC3003
 ##

export NEWLINE=$'\n'
export PS1="$NEWLINE%F{black}%~ $NEWLINE%F{black}❯ %f"

###
 # Make sure that additonal info isn't shown on prompt.
 #
 # @since  Wednesday, June 29, 2022 (Moved to this file)
 ##
precmd() {
	setopt localoptions nopromptsubst
}
