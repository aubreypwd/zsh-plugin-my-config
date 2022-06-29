#!/bin/zsh

###
 # Functions
 #
 # @since Tuesday, April 19, 2022
 ##

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
 # Serve a website using PHP -S
 #
 # E.g: serve "domain.tld" 7.4
 #
 # @since Thursday, June 23, 2022
 ##
function serve {

	domain="$1"

	if [ -z "$1" ]; then
		domain="localhost"
	fi

	version="$2"

	if [ -z "$2" ]; then
		version="8.1"
	fi

	case $version in

		7.4)
			version="/opt/homebrew/Cellar/php@7.4/7.4.30/bin/php"
			;;

		8.1)
			version="/opt/homebrew/Cellar/php/8.1.7/bin/php"
			;;

		*)
			version=$(which php)
			;;
	esac

	sudo "$version" -S "$domain:80"
}