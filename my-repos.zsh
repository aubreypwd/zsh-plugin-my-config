#!/bin/bash

###
 # My Repos
 #
 # @since Tuesday, April 19, 2022
 ##

 # vcsh
 alias pub='vcsh pub'
 alias priv='vcsh priv'

###
 # A way to output a dirty message.
 #
 # @since Friday, August 27, 2021
 ##
_repo-is-dirty () {

	FULL="\e[31m⑂\e[0m \e[33m$1\e[0m is dirty, use \e[32m$2\e[0m to access git."
	TILDE="~"

	echo -e "${FULL/$HOME/$TILDE}"
}

###
 # Wrapper for git-is-clean messaging
 #
 # @since Friday, August 27, 2021
 ##
repo-status () {

	# Configs & Repos
	alias "$2"="git -C "$1""

	git-is-clean "$1" || ( _repo-is-dirty "$1" "$2" )
}

###
 # Call this function to watch these repos.
 #
 # Not git pew is an alias in my .gitconfig
 #
 # @since Wednesday, April 20, 2022
 # @since Sep 20, 2023 Changed to repos
 ##
repo-statuses () {

	# Watch these repositories for dirtiness.
	# repo-status "$HOME/Pictures/Profile Photos" "photos"
	# repo-status "$HOME/Repos/github.com/aubreypwd/Alfred.alfredpreferences" "alfred"
	repo-status "$HOME/Repos/github.com/aubreypwd/iTerm2" "iterm"
	repo-status "$HOME/Repos/github.com/aubreypwd/subl-snippets" "snippets"
	repo-status "$HOME/Repos/github.com/aubreypwd/safari-userscripts" "safari"
	repo-status "$HOME/Repos/github.com/aubreypwd/zsh-plugin-my-config" "config"

	if [[ ! $( command -v vcsh ) ]]; then
		echo "vcsh missing, please install so I can watch pub and priv!"
	else

		# Then check if we have anything else after that going on with vcsh.
		vcsh pub diff-index --quiet --ignore-submodules HEAD || _repo-is-dirty "vcsh (Public)" "pub"
		vcsh priv diff-index --quiet --ignore-submodules HEAD || _repo-is-dirty "vcsh (Private)" "priv"
	fi
}
