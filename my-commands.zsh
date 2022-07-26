#!/bin/sh

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
alias edit-zsh="edit ~/.zshrc"
	alias ezsh="edit-zsh"
alias edit-git="edit ~/.gitconfig"
	alias egit="edit-git"
alias edit-ssh="edit ~/.ssh/config"
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
alias repo="cd ~/Repos && fdd" # An easy way to get to a repo using my ffd command.
alias loc="cd ~/Sites/Local && fd && cd app/public || true" # Quick way to get to a site
alias site="cd ~/Sites && fd || true"
alias antigenfd="cd ~/.antigen/bundles/aubreypwd && fd" # An easy way to get to a bundle.
alias locals="cd ~/Sites/Local && fd 3" # An easy way to get to a local.
alias high='highlight -O ansi'

# Installs (NPM)
alias npmai="n auto && npm i"
alias npmaci="n auto && npm ci"

# Build (NPM)
alias npmcib="npmaci && npmrb && b"
alias npmib="npmai && npmrb && b"
alias npmrb="npm run build && b"

# Dev (NPM)
alias npmcid="npmaci && npmrd"
alias npmid="npmai && npmrd"
alias npmibd="npmai && npmrb && npmrd"
alias npmrd="npm run dev || npm run watch || npm run start || true"

# Homebrew
alias brewd="brew bundle dump --file=$HOME/.Brewfile --verbose --all --describe --force --no-lock" # Dump what's installed to my Brewfile

# Sounds
alias bell="tput bel"
alias beep="bell"
alias b="bell"

# diff folders
alias diffd="diff -rq" # Diff a directory.

# There are aliases in my-repos.zsh

# Misc
alias matrix='cmatrix'

# WP-CLI
alias wpeach='wp site list --field=url | xargs -n1 -I % wp --url=%' # On each subsite, run a command.
alias wpdbn="wp config get DB_NAME" # What is the database name

# xattr
alias clearatts="xattr -cr"

# Databases
alias db='mycli -u root -h 127.0.0.1'
alias dbs="mysql -u root -e 'show databases;'"

# Finder
alias finder='open -F -a Finder' # Open Finder but remember the window size when you open.

# DNS
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'

# AwesomeMotive / AffiliateWP
alias affwp:build='composer install || composer update && na && npm ci || npm i && npm run build'

# PHP
alias php5="/opt/homebrew/Cellar/php@5.6/5.6.40_4/bin/php"
alias php7="/opt/homebrew/Cellar/php@7.4/7.4.30/bin/php"
alias php8="/opt/homebrew/Cellar/php/8.1.7/bin/php"
alias phpv="php -r 'echo phpversion() . \"\n\";' | sed 's/ *$//g'" # Get just the version number.

	# PHP switching
	alias php@5="brew unlink php && brew unlink php@5.6 && brew link --overwrite php@5.6 --force && composer global update && php --version"
	alias php@7="brew unlink php && brew unlink php@7.4 && brew link --overwrite php@7.4 --force && composer global update && php --version"
	alias php@8="brew unlink php && brew unlink php@8.1 && brew link --overwrite php@8.1 --force && composer global update && php --version"
	alias php@sys="php@7" # The version I want to use on my system.

	# PHP -S
	alias serve="sudo php -S localhost:80"
	alias serve5="sudo /opt/homebrew/Cellar/php@5.6/5.6.40_4/bin/php -S localhost:80"
	alias serve7="sudo /opt/homebrew/Cellar/php@7.4/7.4.30/bin/php -S localhost:80"
	alias serve8="sudo /opt/homebrew/Cellar/php/8.1.7/bin/php -S localhost:80"

		# Multisite
		alias servemu="sudo php -S mu.localhost:80"
		alias serve5mu="sudo /opt/homebrew/Cellar/php@5.6/5.6.40_4/bin/php -S mu.localhost:80"
		alias serve7mu="sudo /opt/homebrew/Cellar/php@7.4/7.4.30/bin/php -S mu.localhost:80"
		alias serve8mu="sudo /opt/homebrew/Cellar/php/8.1.7/bin/php -S mu.localhost:80"

# Antigen
alias	plugin="cd $HOME/.antigen/bundles/aubreypwd && fd"

# Screens
alias screens="screen -ls"
alias xd="screen -d" # Just detach from the screen.

# Node
alias na='n auto'
alias nl='n lts'
alias n12='n 12'
alias n10='n 10'
alias n14='n 14'
alias n16='n 14'

###
 # Execute SQL in MySQL.
 #
 # @since Wednesday, July 13, 2022
 ##
function mysql-exec {
	mysql -u root -e "$@"
}

	# Shortcuts
	alias mysqlx='mysql-exec'
	alias dbx='mysql-exec'

###
 # Delete a databse.
 #
 # @since Wednesday, July 13, 2022
 ##
function mysql-dropdb {
	mysql-exec "DROP DATABASE $1;"
}

	# Shortcuts
	alias dbd='mysql-dropdb'

###
 # Open a new screen by session name.
 #
 # @since Thursday, July 7, 2022
 ##
function oscreen {
	screen -r "$ITERM_SESSION_ID" || screen -S "$ITERM_SESSION_ID"
}

###
 # Open a new screen by name.
 #
 # @since Thursday, July 7, 2022
 ##
function oScreen {
	screen -r "$1" || screen -S "$1"
}

###
 # Easy way to configure WP CLI in LocalWP.
 #
 # E.g: lwpcliconfig ".../Library/Application Support/Local/run/6vRk6evkc/mysql/mysqld.sock"
 #
 # @since Thursday, April 7, 2022
 ##
function lwpcliconfig {

	cp "/Users/aubreypwd/Documents/Development/wp-cli.local/wp-cli.local.php" "./"
	cp "/Users/aubreypwd/Documents/Development/wp-cli.local/wp-cli.local.yml" "./"

	echo "$1" > "wp-cli.local.sock"
}

###
 # Get the name of the current directory.
 #
 # @since Thursday, June 30, 2022
 ##
function nwd {
	echo "${PWD##*/}";
}

###
 # System information.
 #
 # @since Thursday, July 7, 2022
 ##
function sysinfo() {

	echo "\e[35mƤ PHP:\e[0m   \e[37m$(phpv)\e[0m" # Show the current working directory.
	echo "\e[32m⊔ Node:\e[0m  \e[37m$(node --version)\e[0m" # Show the current working directory.
	echo "\e[37m $(pwd)\e[0m" # Show the current working directory.
}

###
 # Install debugging tools for WordPress.
 #
 # @since Thursday, June 30, 2022
 ##
function iwpdebug {

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
	wp plugin install --activate debug-bar
	wp plugin install --activate debug-bar-console
	wp plugin install --activate debug-bar-shortcodes
	wp plugin install --activate debug-bar-constants
	wp plugin install --activate debug-bar-post-types
	wp plugin install --activate debug-bar-cron
	wp plugin install --activate debug-bar-actions-and-filters-addon
	wp plugin install --activate debug-bar-transients
	wp plugin install --activate debug-bar-list-dependencies
	wp plugin install --activate debug-bar-remote-requests
	wp plugin install --activate query-monitor
}

###
 # Setup composer for WordPress.
 #
 # @since Thursday, June 30, 2022
 ##
function scomposerwp {

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
function newphpswp {

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
function gharchive {

	gh repo archive -y
	gh api "repos/aubreypwd/${PWD##*/}/transfer" -f new_owner=4ubr3ypwd
	rm -Rf $(pwd)

	exit
}

###
 # Export a DB using WP-CLI.
 #
 # ...and compress.
 #
 # @since Monday, April 25, 2022
 ##
function wpdbx {
	wp db export - | gzip -9 -f > "$1.tar.gz"
}

###
 # Switch database (interactive)
 #
 # @since Tuesday, July 26, 2022
 ##
function wpdbsw {

	dbs
	echo "Current DB_NAME: $(wpdbn)"

	vared -p 'Which DB?: ' -c wpdbsw_db && \
		wpdbs $wpdbsw_db
}

###
 # Switch databases (by name).
 #
 # E.g: wpdbs DB_NAME
 #
 # @since Wednesday, July 6, 2022
 ##
function wpdbs {
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
function wpci {

	if [[ ! -e "wp-config.php" ]]; then

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
function wpdbi {
	gzip -c -d "$1" | wp db import -
}

###
 # Notifications
 #
 # E.g: not "Title" "SubTitle" "Message"
 #
 # @since
 ##
function -- {
	terminal-notifier -title "$1" -subtitle "$2" -message "$3" -activate 'com.googlecode.iterm2' --sound "boop"
}

###
 # Reset Finder
 #
 # E.g: rfinder
 #
 # @since Tuesday, December 21, 2021
 ##
function rfinder {
	find "$HOME" -name ".DS_Store" -depth -exec rm {} \;
}

###
 # Watch files.
 #
 # E.g: watchf ./ js,css,php "cmd"
 #
 # @since Monday, October 11, 2021
 ##
function watchf {
	clear
	watchexec --watch "$1" -e "$2" "$3" -c -p
}

###
 # Hide an app from the Dock.
 #
 # E.g: hideindock "Tower"
 #
 # @since Monday, October 11, 2021
 ##
function hideindock {
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
function showindock {
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
function screenc {
	screen -S "$@" -d -m zsh -c "$@"
}

###
 # Background Job
 #
 # @since Sunday, July 3, 2022
 ##
function bg {
	builtin bg %"$@"
}

###
 # Foreground Job
 #
 # @since Sunday, July 3, 2022
 ##
function fg {
	builtin fg %"$@"
}

###
 # Suspend Job
 #
 # @since Sunday, July 3, 2022
 ##
function sus {
	kill -STOP "$@"
}

###
 # Jobs
 #
 # @since Sunday, July 3, 2022
 ##
function jobs {
	if [ -z "$1" ]; then
		builtin jobs -l
	else
		builtin jobs -l %"$@"
	fi
}

###
 # Continue Job
 #
 # @since Sunday, July 3, 2022
 ##
function cont {
	kill -CONT "$@"
}

###
 # Find the folder where a file is.
 #
 # @since Thursday, July 14, 2022
 ##
function fd-f () {
	if ! [[ -x $(command -v fzf) ]]; then
		echo "Please install fzf (specifically fzf-tmux) to use fd." >&2 && return
	fi

	if ! [[ -x $(command -v find) ]]; then
		echo "Requires find command." >&2 && return
	fi

	local DEPTH=1000

	if [ -n "$1" ]; then
		DEPTH="$1"
	fi

	local FILE=`find -L * -maxdepth $DEPTH -type f -print 2> /dev/null | fzf-tmux`  && cd $(dirname "$FILE") && ls -lh $(basename "$FILE")
}

	alias fdf="fd-f"