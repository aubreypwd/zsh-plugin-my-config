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

	full="\e[31m⑂\e[0m \e[33m$1\e[0m is dirty"
	macos="$1 is dirty!"
	tilde="~"

	# Only show if opening new terminal session at ~
	if [[ $(pwd) == $HOME ]]; then
		echo -e "${full/$HOME/$tilde}"
	fi
}

###
 # Wrapper for git-is-clean messaging
 #
 # @since Friday, August 27, 2021
 ##
function __watchrepo {
	git-is-clean "$1" || ( __dirty_message "$1" )
}

###
 # Call this function to watch these repos.
 #
 # Not git pew is an alias in my .gitconfig
 #
 # E.g: checkmyrepos
 #
 # @since Wednesday, April 20, 2022
 ##
function checkmyrepos {

	# Send updates upstream for these before we check them.
	git --git-dir ~/Repos/github.com/aubreypwd/Alfred.alfredpreferences/.git pew &> /dev/null
	git --git-dir ~/Repos/github.com/aubreypwd/iTerm2/.git pew &> /dev/null

	# Watch these repositories for dirtiness.
	__watchrepo "$HOME/iCloud/Profile Photos"
	__watchrepo "$HOME/Repos/github.com/aubreypwd/Alfred.alfredpreferences"
	__watchrepo "$HOME/Repos/github.com/aubreypwd/iTerm2"
	__watchrepo "$HOME/Repos/github.com/aubreypwd/safari-user-scripts"
	__watchrepo "$HOME/Repos/github.com/aubreypwd/subl-snippets"

	# My ZSH plugins/configurations.
	__watchrepo "$HOME/.antigen/bundles/aubreypwd/zsh-plugin-my-config"

	if [[ ! $( command -v vcsh ) ]]; then

		echo "vcsh missing, please install so I can watch pub and priv!"
	else

		# Then check if we have anything else after that going on with vcsh.
		vcsh pub diff-index --quiet --ignore-submodules HEAD || __dirty_message "pub"
		vcsh priv diff-index --quiet --ignore-submodules HEAD || __dirty_message "priv"
	fi
}
