#!/bin/bash

###
 # My Commands
 #
 # @since Thursday, 10/1/2020      Moved over from .config
 # @since Apr 19, 2022             Move to own plugin.
 # @since Wednesday, July 13, 2022 Combined with Aliases + Functions.
 ##

# Editor
if [ "$TERM_PROGRAM" = "Terminus-Sublime" ]; then
	alias edit="subl -n -w"
else
	alias edit="vim"
fi

alias e="edit"

# Editing Config Files
alias edit-zsh="edit $HOME/.zshrc"
	alias ezsh="edit-zsh"
alias edit-git="edit $HOME/.gitconfig"
	alias egit="edit-git"
alias edit-ssh="edit $HOME/.ssh/config"
	alias essh="edit-ssh"

# Basics
alias cat="bat"
alias nw='ttab -w' # New window.
alias nt='ttab ' # New tab.
alias ntx="nt && x"
alias c=clear
alias tower='gittower'
alias fakedata="fakedata --limit 1"

# Easy composer commands.
#alias cu="composer uninstall"
alias cis="composer install --prefer-source --ignore-platform-reqs" # source install.
alias cid="composer install --prefer-dist --ignore-platform-reqs" # dist install.
# alias crd="composer uninstall && composer install --prefer-dist" # reinstall with dist.
# alias crs="composer uninstall && composer install --prefer-source" # reinstall with source.
alias ccc="composer clearcache && composer global clearcache"

# Composer versions
alias c@2="composer self-update --2"
alias c@1="composer self-update --1"

# Fuzzy find at certain levels easily.
alias fdd="fd 2" # Two levels.
alias fd!="fd 10" # Deeper.
alias fd~="fd 50" # Super deep.

# Misc.
alias vim="vim -c 'startinsert'" # Start Vim in insert mode (mostly for commit writing).
alias repo="cd $HOME/Repos && fdd" # An easy way to get to a repo using my ffd command.
alias site="cd $HOME/Sites && fd && cd 'app/public' || true" # Quick way to get to a site
alias high='highlight -O ansi'

# Sounds
alias bell="tput bel"
alias beep="bell"
alias b="bell"

# diff folders
alias diffd="diff -rq" # Diff a directory.
	alias diffdir="diffd"

# Misc
alias matrix='cmatrix'

# WP-CLI
alias wpeach='wp site list --field=url | xargs -n1 -I % wp --url=%' # On each subsite, run a command.
alias wpdbn="wp config get DB_NAME" # What is the database name

# xattr
alias clearatts="xattr -cr"
	alias catts="clearatts"

# DNS
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'

# PHP switching
alias php@5="brew unlink php && brew unlink php@5.6 && brew link --overwrite php@5.6 --force && composer global update && php --version"
alias php@7="brew unlink php && brew unlink php@7.4 && brew link --overwrite php@7.4 --force && composer global update && php --version"
alias php@8="brew unlink php && brew unlink php@8.1 && brew link --overwrite php@8.1 --force && composer global update && php --version"

# Screens
alias screens="screen -ls"
alias xd="screen -d" # Just detach from the screen.

# Node
alias n@a='n auto'
	alias na='n@a'
alias n@lts='n lts'
alias n@12='n 12'
alias n@10='n 10'
alias n@14='n 14'
alias n@16='n 14'

###
 # Open a .sublime-project
 #
 # Staring with the current directory.
 #
 # @since Tuesday, August 2, 2022
 ##
sublop () {

	if [ -e "$1" ]; then

		subl --project "$1"
		return 0
	fi

	if ls ./*.sublime-project || false; then

		local SUBL_PROJECT_FILE='' && \
			SUBL_PROJECT_FILE="$( find '.' -type f -name '*.sublime-project' | fzf )"

		if [ -z "$SUBL_PROJECT_FILE" ]; then

			echo "No *.sublime-project selected, opening $(nwd) in Sublime Text..."

			subl -n .

			return 0
		fi

		echo "Opening $SUBL_PROJECT_FILE in SublimeText..."

		subl --project "$SUBL_PROJECT_FILE"

		return 0
	fi

	echo "No *.sublime-project files, opening $(nwd) in Sublime Text..."

	subl -n .
}

	alias subl.='sublop'

###
 # Get the PHP version running.
 #g
 # @usedby sysinfo()
 #
 # @since Tuesday, August 2, 2022
 ##
phpv () {
	php -r 'echo phpversion() . "\n";' | sed 's/ *$//g'
}

###
 # Go to one of my plugins (Antigen)
 #
 # @since Tuesday, July 26, 2022
 ##
plugin () {
	cd "$HOME/.antigen/bundles/aubreypwd" || false && fd
}

###
 # Dump .Brewfile
 #
 # @since Tuesday, July 26, 2022
 ##
brewd () {
	brew bundle dump --file="$HOME/.Brewfile" --verbose --all --describe --force --no-lock "$@"
}

###
 # Easy way to configure WP CLI in LocalWP.
 #
 # @since Thursday, April 7, 2022
 ##
lwpclisock () {

	if [ ! -e './wp-content' ]; then

		echo "Please run in the site root (where the wp-content/ folder is, but not inside)."
		return 1
	fi

	if [ -z "$( antigendir || false )" ]; then

		echo "antigendir command not found."
		return 1
	fi

	local ANTIGENDIR && ANTIGENDIR="$( antigendir )"

	if [ -z "$1" ]; then

		echo "Please supply a sock file as the first argument."
		return 1
	fi

	if [ ! -e "$1" ]; then

		echo "Sock file $1 does not exist, please copy sock path from LocalWP."
		return 1
	fi

	local LWP_ASSETS_DIR="$ANTIGENDIR/bundles/aubreypwd/zsh-plugin-my-config/assets/localwp/"

	if [ ! -e "$LWP_ASSETS_DIR" ]; then

		echo "$LWP_ASSETS_DIR missing!"
		return 1
	fi

	cp "$LWP_ASSETS_DIR/wp-cli.local.php" "./"
	cp "$LWP_ASSETS_DIR/wp-cli.local.yml" "./"

	echo "$1" > "./wp-cli.local.sock"

	wp option get home
}

###
 # Get the .antigen directory.
 #
 # @since Tuesday, August 2, 2022
 ##
antigendir () {
	echo "$HOME/.antigen";
}

###
 # Get the name of the current directory.
 #
 # @since Thursday, June 30, 2022
 ##
nwd () {
	echo "${PWD##*/}";
}

###
 # System information.
 #
 # @since Thursday, July 7, 2022
 ##
sysinfo () {

	echo "\e[35mƤ PHP:\e[0m   \e[37m$(phpv)\e[0m" # Show the current working directory.
	echo "\e[32m⊔ Node:\e[0m  \e[37m$(node --version)\e[0m" # Show the current working directory.
	echo "\e[37m $(pwd)\e[0m" # Show the current working directory.
}

###
 # Install debugging tools for WordPress.
 #
 # @since Thursday, June 30, 2022
 ##
iwpdebug () {

	# Debugging constants.
	wp config set BP_DEFAULT_COMPONENT 'staging-area'
	wp config set BP_XPROFILE_SLUG 'staging-area'
	wp config set COMPRESS_CSS false --raw
	wp config set COMPRESS_SCRIPTS false --raw
	wp config set CONCATENATE_SCRIPTS false --raw
	wp config set DISABLE_WP_CRON true --raw
	wp config set ENFORCE_GZIP false --raw
	wp config set EP_DASHBOARD_SYNC false --raw
	wp config set EP_HOST 'http://failed.tld/'
	wp config set FS_CHMOD_DIR 0775 --raw
	wp config set FS_CHMOD_FILE 0664 --raw
	wp config set FS_METHOD 'direct'
	wp config set JETPACK_DEV_DEBUG true --raw
	wp config set SAVE_QUERIES true --raw
	wp config set SCRIPT_DEBUG true --raw
	wp config set WP_AUTO_UPDATE_CORE false --raw
	wp config set WP_CACHE false --raw
	wp config set WP_DEBUG true --raw
	wp config set WP_DEBUG_DISPLAY false --raw
	wp config set WP_DEBUG_LOG true --raw
	wp config set WP_ENVIRONMENT_TYPE local
	wp config set WP_LOCAL_DEV true --raw
	wp config set WP_MAX_MEMORY_LIMIT 4096 --raw
	wp config set WP_MEMORY_LIMIT 4096 --raw

	# Debugging plugins.
	wp plugin install debug-bar
	wp plugin install debug-bar-console
	wp plugin install debug-bar-shortcodes
	wp plugin install debug-bar-constants
	wp plugin install debug-bar-post-types
	wp plugin install debug-bar-cron
	wp plugin install debug-bar-actions-and-filters-addon
	wp plugin install debug-bar-transients
	wp plugin install debug-bar-list-dependencies
	wp plugin install debug-bar-remote-requests
	wp plugin install query-monitor
}

###
 # Setup composer for WordPress.
 #
 # @since Thursday, June 30, 2022
 ##
scomposerwp () {

	composer init --name "aubreypwd/$(nwd)" --require "spatie/ray:^1.0" --require "aubreypwd/php-s-wp:dev-main@dev" --no-interaction
	composer install --no-interaction

	wp config set '__SPATIE_RAY' "require __DIR__ . '/vendor/autoload.php'" --raw --type='variable'
}

###
 # New php -S WordPress site.
 #
 # Create a directory and run this command inside it.
 #
 # @since Thursday, June 30, 2022
 ##
newphpswp () {

	wp core download
	wp config create --dbname="$(nwd)" --dbuser="root"
	wp db create
	wp core install --url="http://localhost" --title="$(nwd)" --admin_email="code@aubreypwd.com" --admin_user="admin"
	wp user update admin --user_pass="password"

	scomposerwp
	iwpdebug
}

###
 # Easy way to archive a repo and transfer it to 4ubr3ypwd.
 #
 # E.g: gharchive
 #
 # @since Wednesday, June 29, 2022
 ##
gharchive () {

	gh repo archive -y
	gh api "repos/aubreypwd/${PWD##*/}/transfer" -f new_owner=4ubr3ypwd

	rm -Rf "$(pwd)"

	exit
}

###
 # Export a DB using WP-CLI.
 #
 # ...and compress.
 #
 # @since Monday, April 25, 2022
 ##
wpdbx () {
	wp db export - | gzip -9 -f > "$1.tar.gz"
}

###
 # Switch database (interactive)
 #
 # @since Tuesday, July 26, 2022
 ##
wpdbsw () {

	dbs
	echo "Current DB_NAME: $(wpdbn)"

	local wpdbsw_db=""

	vared -p 'Which DB?: ' -c wpdbsw_db

	if [ -e "$wpdbsw_db" ]; then

		echo "No DB specified."
		return 0
	fi

	wpdbs "$wpdbsw_db"
}

###
 # Switch databases (by name).
 #
 # E.g: wpdbs DB_NAME
 #
 # @since Wednesday, July 6, 2022
 ##
wpdbs () {
	wp config set DB_NAME "$1" && \
		wp option get home
}

###
 # wp core install (Automated)
 #
 # E.g: wpci "name-of-database"
 #
 # @since Wednesday, July 6, 2022
 ##
wpci () {

	if [ ! -e "wp-config.php" ]; then

		echo "Not an active WordPress install, use wp config create first."
		return
	fi

	wpdbs "$1"

	wp db create && \
		wp core install --title="$1" --url="https://$(nwd).test" --admin_user="admin" --admin_email="aubreypwd@icloud.com" && \
			wp user update admin --user_pass=password && \
				wp option get home
}

###
 # Import a DB using WP-CLI.
 #
 # ...that's compressed.
 #
 # @since Tuesday, April 26, 2022
 ##
wpdbi () {
	gzip -c -d "$1" | wp db import -
}

###
 # Notifications
 #
 # E.g: not "Title" "SubTitle" "Message"
 #
 # @since
 ##
-- () {
	terminal-notifier -title "$1" -subtitle "$2" -message "$3" -activate 'com.googlecode.iterm2' --sound "boop"
}

###
 # Reset Finder
 #
 # E.g: rfinder
 #
 # @since Tuesday, December 21, 2021
 ##
rmds_store () {
	find "$HOME" -name ".DS_Store" -depth -exec rm {} \;
}

###
 # Open finder in the Terminal.
 #
 # This works because we always open Finder in the ~ folder, which
 # opens a normal window. Then we open a new window (tab) in Finder.
 #
 # @since Aug 11, 2022
 ##
finder () {
	open -a Finder && \
		open .
}

###
 # False (an error).
 #
 # @since Wednesday, July 27, 2022
 ##
__return_1 () {
	return 1
}

###
 # True (no error).
 #
 # @since Wednesday, July 27, 2022
 ##
__return_0 () {
	return 0
}

###
 # Watch files by extension
 #
 # E.g: watchf ./ js,css,php "cmd"
 #
 # @since Monday, October 11, 2021
 ##
watchfext () {

	clear
	watchexec --watch "$1" -e "$2" "$3" -c -p
}

	alias watchf-ext='watchfext'

###
 # Hide an app from the Dock.
 #
 # E.g: hideindock "Tower"
 #
 # @since Monday, October 11, 2021
 ##
hideindock () {
	/usr/libexec/PlistBuddy -c 'Add :LSUIElement bool true' "$1/Contents/Info.plist" &> /dev/null
}
	alias hide-in-dock='hideindock'

###
 # Show an app in the Dock.
 #
 # E.g: showindock "Tower"
 #
 # @since Monday, October 11, 2021
 ##
showindock () {
	/usr/libexec/PlistBuddy -c 'Delete :LSUIElement' "$1/Contents/Info.plist" &> /dev/null
}
	alias show-in-dock="showindock"

###
 # Run a command in a detached screen.
 #
 # E.g:
 #
 # @since Sunday, July 3, 2022
 ##
screenc () {
	screen -S "$@" -d -m zsh -c "$@"
}

###
 # Background Job
 #
 # @since Sunday, July 3, 2022
 ##
bg () {
	builtin bg % "$@"
}

###
 # Foreground Job
 #
 # @since Sunday, July 3, 2022
 ##
fg () {
	builtin fg % "$@"
}

###
 # Suspend Job
 #
 # @since Sunday, July 3, 2022
 ##
sus () {
	kill -STOP "$@"
}

###
 # Jobs
 #
 # @since Sunday, July 3, 2022
 ##
jobs () {

	if [ -z "$1" ]; then
		builtin jobs -l
	else
		builtin jobs -l % "$@"
	fi
}

###
 # Continue Job
 #
 # @since Sunday, July 3, 2022
 ##
cont () {
	kill -CONT "$@"
}

###
 # Find the folder where a file is.
 #
 # @since Thursday, July 14, 2022
 ##
fdf () {

	if ! [ -x "$(command -v fzf)" ]; then
		echo "Please install fzf (specifically fzf-tmux) to use fd." >&2 && return
	fi

	if ! [ -x "$(command -v find)" ]; then
		echo "Requires find command." >&2 && return
	fi

	local depth=1000

	if [ -n "$1" ]; then
		depth="$1"
	fi

	local file=''

	file=$( find -L ./* -maxdepth "$depth" -type f -print 2> /dev/null | fzf-tmux )

	cd "$(dirname "$file")" && ls -lh "$(basename "$file")"
}

	# Aliases for fdf
	alias fd-f="fdf"

###
 # Switch to the system preferred npm.
 #
 # @since Tuesday, July 26, 2022
 ##
sysnpm () {
	( cd "$HOME" && n auto )
}

	# Aliases for sysnpm
	alias npm@sys='sysnpm'
	alias sys-npm='sysnpm'

###
 # My custom affwp commands.
 #
 # If my custom sub-commands aren't here,
 # then they are in https://github.com/aubreypwd/zsh-plugin/affwp.
 #
 # Many of these are here because they rely on my system command/etc.
 #
 # @since Thursday, July 28, 2022
 ##
affwp () {

	# Database controls.
	if [ "$1" = 'db' ]; then

		case "$2" in

			###
			 # Reset using the reset tar that should be in dbx.
			 #
			 # @since Thursday, July 28, 2022
			 ##
			'reset' )
				test -e "$HOME/Databases/Exports/mysql/affwp-dev@reset.tar.gz" || return 1 && \
					wpdbi "$HOME/Databases/Exports/mysql/affwp-dev@reset.tar.gz" && \
						wp option set blogname "$(wpdbn)" && \
							return 0
			;;

			###
			 # Switch DB and Import file.
			 #
			 # affwp db si $3{DB_NAME} $4{foo.tar.gz}
			 #
			 # @since Thursday, July 28, 2022
			 ##
			'si' ) __affwp_sdbi "$3" "$4" && return 0;;

			###
			 # Switch to another DB.
			 #
			 # Just a wrapper of wpdbs
			 #
			 # @since Thursday, July 28, 2022
			 ##
			's' )
				wpdbs "$(nwd)@$3" &&
					( wp db create || true ) && \
						return 0;
			;;

			###
			 # Switch the db to the current git branch.
			 #
			 # affwp db gb $3{affwp-dev}
			 #
			 # @since Thursday, July 28, 2022
			 ##
			'gb' )
				risd "$3" affwp db s "$(git b)" && \
					risd "$3" wp option set blogname "$3@$(git b)"
			;;

			# Default
			* ) echo "Sub-commands: reset, si, s, gb" && return 1;;

		esac
	fi

	__affwp "$@" # Not my custom subcommands, use the one from the package.
}

###
 # Run a command in a directory.
 #
 # @since Thursday, July 28, 2022
 ##
rid () {
	( cd "$1" && "${@:2}" )
}

###
 # Run a command in a site directory.
 #
 # @since Thursday, July 28, 2022
 ##
risd () {
	rid "$HOME/Sites/$1" "${@:2}"
}