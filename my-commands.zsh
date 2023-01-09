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

# Aliases
alias b="bell"
alias beep="bell"
alias bell="tput bel"
alias c=clear
alias c@1="composer self-update --1"
alias c@2="composer self-update --2"
alias cat="bat"
alias catts="clearatts"
alias ccc="composer clearcache && composer global clearcache"
alias cid="composer install --prefer-dist --ignore-platform-reqs" # dist install.
alias cis="composer install --prefer-source --ignore-platform-reqs" # source install.
alias clearatts="xattr -cr"
alias cwd="pwdcp"
alias diffd="diff -rq" # Diff a directory.
alias diffdir="diffd"
alias e="edit"
alias edit-git="edit $HOME/.gitconfig"
alias edit-ssh="edit $HOME/.ssh/config"
alias edit-zsh="edit $HOME/.zshrc"
alias egit="edit-git"
alias essh="edit-ssh"
alias ezsh="edit-zsh"
alias fakedata="fakedata --limit 1"
alias fd!="fd 10" # Deeper.
alias fdd="fd 2" # Two levels.
alias fd~="fd 50" # Super deep.
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias high='highlight -O ansi'
alias j='jrnl'
alias j10="jrnl -n 10 -s"
alias j20="jrnl -n 20 -s"
alias j!="jrnl -n 9999999 -s"
alias J!="jrnl -n 999999"
alias lg="lazygit"
alias matrix='cmatrix'
alias n@10='n 10'
alias n@12='n 12'
alias n@14='n 14'
alias n@16='n 14'
alias n@a='n auto'
alias n@lts='n lts'
alias na='n@a'
alias nt='ttab ' # New tab.
alias ntx="nt && x"
alias nw='ttab -w' # New window.
alias php@5="brew unlink php && brew unlink php@5.6 && brew link --overwrite php@5.6 --force && composer global update && php --version"
alias php@7="brew unlink php && brew unlink php@7.4 && brew link --overwrite php@7.4 --force && composer global update && php --version"
alias php@8="brew unlink php && brew unlink php@8.1 && brew link --overwrite php@8.1 --force && composer global update && php --version"
alias repo="cd $HOME/Repos && fdd" # An easy way to get to a repo using my ffd command.
alias s="say"
alias screens="screen -ls"
alias site="cd $HOME/Sites && fd || true" # Quick way to get to a site
alias tower='gittower'
alias tunnel="cloudflared tunnel run"
alias vimi="vim -c 'startinsert'" # Start Vim in insert mode (mostly for commit writing).
alias wp="$(brew --prefix php@7.4)/bin/php /opt/homebrew/bin/wp"
alias wpdbn="wp config get DB_NAME" # What is the database name
alias wpeach='wp site list --field=url | xargs -n1 -I % wp --url=%' # On each subsite, run a command.
alias xd="screen -d" # Just detach from the screen.

###
 # Get the site name from the database for this install.
 #
 # @since Oct 18, 2022
 ##
wpblogname () {
	wp option get blogname
}

###
 # Get the home url from the database for this install.
 #
 # @since Oct 18, 2022;
 ##
wphome () {
	wp option get home
}

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
 # @since Oct 13, 2022           Renamed to gotoplugin.
 ##
gotoplugin () {
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
wpdebugi () {

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
 # Switching Databases
 #
 # @since Wednesday, July 6, 2022
 # @since Oct 12, 2022            Refactored to work with files vs internally switching.
 # @since Oct 13, 2022            Renamed to lwpdbs.
 # @since Oct 28, 2022            Renamed to wpdbs since it always works with the dbs/ folder.
 ##
wpdbs () {

	# Please run this in the root.
	if [ ! -e "wp-config.php" ]; then

		echo "Sorry, but you have to run this in the root of the install."
		return 1
	fi

	local target_db="$1"
	local export_db="$2"

	# Keep the URL the same as the current install.
	local install_url=""
		install_url="$(wp option get home)"

	if [ -z "$install_url" ]; then

		echo "Could not determine install's current URL, can't continue (maybe you have a single site DB but have multisite on?)."
		return 1
	fi

	if [ -z "$target_db" ]; then

		echo "Please supply new DB name (if dbs/<db>.tar.gz exists it will be imported instead."
		echo
		echo "Usage: wpdbs <db name> <export name>"
		echo

		return 1
	fi

	mkdir -p "dbs"

	# If they supply an export DB name...
	if [ -n "$export_db" ]; then

		# Export the db first, if they want to do that (will overwrite).
		echo "Exporting DB to dbs/$export_db.tar.gz"
		wpdbx "dbs/$export_db"
	else

		# Use the blogname to export the DB.
		echo "Exporting DB to dbs/$(wp option get blogname).tar.gz"
		wpdbx "dbs/$(wp option get blogname)"
	fi

	# Import or create a DB...
	if [ -e "dbs/$target_db.tar.gz" ]; then

		# Import a DB tar that has the same name already in dbs/...
		echo "Importing dbs/$target_db.tar.gz instead of creating new install."
		wpdbi "dbs/$target_db.tar.gz"

	else

		echo "dbs/$target_db.tar.gz does not exist."

		if [ -e "dbs/init.tar.gz" ]; then

			# They have a dbs/init.tar.gz file, use that as a base instead.
			echo "You have dbs/init.tar.gz, importing it instead of creating new install (delete to ensure new installs are created)."
			wpdbi "dbs/init.tar.gz"

			# Set the blogname to the target db when importing a reset so we can export it next time.
			wp option set blogname "$target_db" --url="$install_url"
		else

			echo "Creating new install with a blank DB..."

			# Multisite.
			if [ '1' = "$(wp config get MULTISITE)" ]; then

				# Create a new multisite install.
				wp db reset --yes && \
					wp core multisite-install --title="$target_db" --url="$install_url" --admin_user="admin" --admin_password="password" --admin_email="localdev@spacehotline.com" --skip-email --skip-config

			# Single-site.
			else

				# Create an entirely new single-site install.
				wp db reset --yes && \
					wp core install --title="$target_db" --url="$install_url" --admin_user="admin" --admin_email="localdev@spacehotline.com" && \
						wp user update admin --user_pass="password"
			fi
		fi
	fi

	# Make sure our blogname matches what we imported.
	wp option set blogname "$target_db"

	# Done
	echo "Done!"
	echo "URL:      $(wp option get home)"
	echo "blogname: $(wp option get blogname)"
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
 # Export a DB using WP-CLI.
 #
 # ...and compress.
 #
 # @since Monday, April 25, 2022
 ##
wpdbx () {

	mkdir -p "$(dirname $1)" && \
		wp db export - | gzip -9 -f > "$1.tar.gz"
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
 # Hide an app from the Dock.
 #
 # E.g: hideindock "Tower"
 #
 # @since Monday, October 11, 2021
 ##
hideindock () {
	/usr/libexec/PlistBuddy -c 'Add :LSUIElement bool true' "$1/Contents/Info.plist" &> /dev/null
}

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
	if [ "$1" = 'sub-command' ]; then
		case "$2" in
			'sub-sub-command' )
				echo "Re-factor this into a sub-command." && \
					return 0
			;;

			# Default
			* ) echo "Sub-commands: none" && return 1;;

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
 # Convert any video file to a DVD-ready MPG.
 #
 # This not only converts any file to ~4.7GB it also outputs it to
 # NTSC in MPG format at 720p resolution.
 #
 # @see https://unix.stackexchange.com/a/598360
 #
 # @since Dec 30, 2022
 ##
todvd () {

	local file="$1"
	local target_size_mb=4650 # DVD = 4700 MB
	local target_size=$(( $target_size_mb * 1000 * 1000 * 8 )) # target size in bits
	local length=`ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$file"`
	local length_round_up=$(( ${length%.*} + 1 ))
	local total_bitrate=$(( $target_size / $length_round_up ))
	local audio_bitrate=$(( 128 * 1000 )) # 128k bit rate
	local video_bitrate=$(( $total_bitrate - $audio_bitrate ))

	ffmpeg -i "$file" -b:v "$video_bitrate" -maxrate:v "$video_bitrate" -bufsize:v "$(( $target_size / 20 ))" -b:a "$audio_bitrate" -vf scale=-1:720 -target ntsc-dvd "${file}-${target_size_mb}MB.mpg"
}

###
 # Get how many frames a video has.
 #
 # @since Dec 30, 2022
 # @see   https://stackoverflow.com/a/28376817/1436129
 ##
frames () {
	ffprobe -v error -select_streams v:0 -count_packets -show_entries stream=nb_read_packets -of csv=p=0 "$1"
}

###
 # Use a GUI to manage public VCSH.
 #
 # @since Jan 6, 2023;
 ##
publg () {
	vcsh pub lg
}

###
 # Use a GUI to manage private VCSH.
 #
 # @since Jan 6, 2023;
 ##
privlg () {
	vcsh priv lg
}