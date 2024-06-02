#!/bin/sh

###
 # Aubrey's ZSH Plugin
 #
 # @since Wednesday, June 29, 2022
 #
 # shellcheck disable=SC3046
 ##
source 'my-path.zsh'
source 'my-functions.zsh'
source 'my-commands.zsh'
source 'my-mac-defaults.zsh'
source 'my-misc.zsh'
source 'my-opts.zsh'
source 'my-prompt.zsh'
source 'my-repos.zsh'
source 'my-vars.zsh'
source 'my-require.zsh' # Must load after vars.zsh.
source 'my-vcsh.zsh'
source 'my-ls.zsh'
source 'my-php.zsh'
source 'my-sublime.zsh'
source 'my-mysql.zsh'
source 'my-exts.zsh'

###
 # Startup Operations
 #
 # @since Dec 14, 2023
 ##
startup () {

	printf "Running Your Startup Commands...\n"

	startup-misc
	startup-mac-defaults
	startup-php
	startup-exts
	startup-mysql

	printf "\nDone. Press any key to continue..."
	read -r 1
}
