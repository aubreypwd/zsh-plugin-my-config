#!/bin/zsh

###
 # My Repos
 #
 # @since Tuesday, April 19, 2022
 ##

###
 # A way to output a dirty message.
 #
 # @since Friday, August 27, 2021
 ##
function __dirty_message {

	full="\e[31m⑂\e[0m \e[33m$1\e[0m is dirty, use \e[32m$2\e[0m to access git."
	macos="$1 is dirty!"
	tilde="~"

	echo -e "${full/$HOME/$tilde}"
}

###
 # Wrapper for git-is-clean messaging
 #
 # @since Friday, August 27, 2021
 ##
function __watchrepo {

	# Configs & Repos
	alias "$2"="git -C "$1""

	git-is-clean "$1" || ( __dirty_message "$1" "$2" )
}

# vcsh
alias pub='vcsh pub'
alias priv='vcsh priv'

###
 # Call this function to watch these repos.
 #
 # Not git pew is an alias in my .gitconfig
 #
 # E.g: checkrepos
 #
 # @since Wednesday, April 20, 2022
 # @since Sep 20, 2023 Changed to checkrepos
 ##
function checkrepos {

	# Watch these repositories for dirtiness.
	# __watchrepo "$HOME/Pictures/Profile Photos" "photos"
	# __watchrepo "$HOME/Repos/github.com/aubreypwd/Alfred.alfredpreferences" "alfred"
	__watchrepo "$HOME/Repos/github.com/aubreypwd/iTerm2" "iterm"
	__watchrepo "$HOME/Repos/github.com/aubreypwd/subl-snippets" "snippets"
	__watchrepo "$HOME/Repos/github.com/aubreypwd/safari-userscripts" "safari"
	__watchrepo "$HOME/Repos/github.com/aubreypwd/zsh-plugin-my-config" "config"

	if [[ ! $( command -v vcsh ) ]]; then
		echo "vcsh missing, please install so I can watch pub and priv!"
	else

		# Then check if we have anything else after that going on with vcsh.
		vcsh pub diff-index --quiet --ignore-submodules HEAD || __dirty_message "vcsh (Public)" "pub"
		vcsh priv diff-index --quiet --ignore-submodules HEAD || __dirty_message "vcsh (Private)" "priv"
	fi
}
