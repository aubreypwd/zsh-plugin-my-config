#!/bin/zsh

###
 # My Prompt
 #
 # @since Apr 6, 2023
 ##

export PS1="%F{black}%~ ❯ %f"

###
 # Make sure that additonal info isn't shown on prompt.
 #
 # @since  Wednesday, June 29, 2022 (Moved to this file)
 ##
precmd() {

	setopt localoptions nopromptsubst
	print -rP "%"
	# print -P "%F{yellow}$(cmd_exec_time)%f"
	# unset cmd_timestamp # Reset cmd exec time.
}