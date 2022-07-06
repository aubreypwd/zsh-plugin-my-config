#!/bin/zsh

###
 # Functions
 #
 # @since Tuesday, April 19, 2022
 ##

###
 # Valet use
 #
 # @since Wednesday, July 6, 2022
 ##
function vu {
	valet use "$1" && composer global update
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
 # Switch databases.
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