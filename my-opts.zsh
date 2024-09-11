#!/bin/bash

###
 # My unsetopt's and setopt's.
 #
 # @since Tuesday, April 19, 2022
 #
 # shellcheck disable=SC2155
 ##

unsetopt INC_APPEND_HISTORY # Append history to new shells.
unsetopt SHARE_HISTORY

setopt MONITOR
setopt POSIX_JOBS
setopt LONG_LIST_JOBS
setopt HOMEBREW_NO_ENV_HINTS # Don't show hints.

#export NODE_OPTIONS=--openssl-legacy-provider

export GPG_TTY=$(tty) # GPG Suite.
