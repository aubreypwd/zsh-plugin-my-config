#!/bin/zsh

###
 # My Repos
 #
 # @since Tuesday, April 19, 2022
 ##

###
 # Make sure that additonal info isn't shown on prompt.
 #
 # @since  Wednesday, June 29, 2022 (Moved to this file)
 ##
precmd() {

	setopt localoptions nopromptsubst
	print -P "%F{yellow}$(cmd_exec_time)%f"
	unset cmd_timestamp # Reset cmd exec time.
}