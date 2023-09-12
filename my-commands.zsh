#!/bin/sh

###
 # My Commands
 #
 # @since Thursday, 10/1/2020      Moved over from .config
 # @since Apr 19, 2022             Move to own plugin.
 # @since Wednesday, July 13, 2022 Combined with Aliases + Functions.
 ##

# shellcheck disable=SC2139

# Editor
if test "$TERM_PROGRAM" = "Terminus-Sublime"; then
	alias edit="$EDITOR"
else
	alias edit="$EDITOR"
fi

# Aliases
alias b="bell"
alias beep="bell"
alias bell="tput bel"
alias c=clear
alias c@1="composer self-update --1"
alias c@2="composer self-update --2"
alias cat="bat"
alias ccc="composer clearcache && composer global clearcache"
alias cid="composer install --prefer-dist --ignore-platform-reqs" # dist install.
alias cis="composer install --prefer-source --ignore-platform-reqs" # source install.
alias cpd="cp -Rfa" # Copy a directory.
alias cwd="pwdcp"
alias e="edit"
alias fd2="fd 2" # Two levels.
alias fd10="fd 10" # Deeper.
alias fd50="fd 50" # Super deep.
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias home='cd ~'
alias lg="lazygit"
alias ss='cmatrix' # Sceeen Saver
alias safariextconv='xcrun /Applications/Xcode.app/Contents/Developer/us/bin/safari-web-extension-converter' # Convert Chrome Extensions to Safari Extensions.
alias n@10='n 10'
alias n@12='n 12'
alias n@14='n 14'
alias n@16='n 14'
alias n@18='n 18'
alias n@sys='n auto'
alias n@lts='n lts'
alias nt='ttab ' # New tab.
alias nw='ttab -w' # New window.
alias php@7.4="$(brew --prefix php@7.4)/bin/php"
alias php@8.2="$(brew --prefix php@8.2)/bin/php"
alias repo="cd \$HOME/Repos && fd 2" # An easy way to get to a repo using my ffd command.
alias site="cd \$HOME/Sites && fd || true" # Quick way to get to a site
alias tunnel="cloudflared tunnel run"
alias wp="php@7.4 /opt/homebrew/bin/wp" # Make wp-cli use PHP 7.4.
alias wpeach='wp site list --field=url | xargs -n1 -I % wp --url=%' # On each subsite, run a command.

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
 # Go to one of my plugins (Antigen/ZSH)
 #
 # @since Tuesday, July 26, 2022
 # @since Oct 13, 2022 Renamed to gotoplugin.
 # @since Aug 18, 2023 Renamed to zplugin.
 ##
zplugin () {
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
 #
 # shellcheck disable=SC2028
 ##
sysinfo () {
	echo "\e[35mƤ PHP:\e[0m   \e[37m$(phpv)\e[0m" # Show the current working directory.
	echo "\e[32m⊔ Node:\e[0m  \e[37m$(node --version)\e[0m" # Show the current working directory.
	echo "\e[37m $(pwd)\e[0m" # Show the current working directory.
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
	if test ! -e "wp-config.php"; then

		echo "Sorry, but you have to run this in the root of the install."
		return 1
	fi

	target_db="$1"
	export_db="$2"

	# Keep the URL the same as the current install.
	install_url=""
		install_url="$(wp option get home)"

	if test -z "$install_url"; then

		echo "Could not determine install's current URL, can't continue (maybe you have a single site DB but have multisite on?)."
		return 1
	fi

	if test -z "$target_db"; then

		echo "Please supply new DB name (if dbs/<db>.tar.gz exists it will be imported instead."
		echo
		echo "Usage: wpdbs <db name> <export name>"
		echo

		return 1
	fi

	mkdir -p "dbs"

	# If they supply an export DB name...
	if test -n "$export_db"; then

		# Export the db first, if they want to do that (will overwrite).
		echo "Exporting DB to dbs/$export_db.tar.gz"
		wpdbx "dbs/$export_db"
	else

		# Use the blogname to export the DB.
		echo "Exporting DB to dbs/$(wp option get blogname).tar.gz"
		wpdbx "dbs/$(wp option get blogname)"
	fi

	# Import or create a DB...
	if test -e "dbs/$target_db.tar.gz"; then

		# Import a DB tar that has the same name already in dbs/...
		echo "Importing dbs/$target_db.tar.gz instead of creating new install."
		wpdbr && wpdbi "dbs/$target_db.tar.gz"

	else

		echo "dbs/$target_db.tar.gz does not exist."

		if test -e "dbs/init.tar.gz"; then

			# They have a dbs/init.tar.gz file, use that as a base instead.
			echo "You have dbs/init.tar.gz, importing it instead of creating new install (delete to ensure new installs are created)."
			wpdbr && wpdbi "dbs/init.tar.gz"

			# Set the blogname to the target db when importing a reset so we can export it next time.
			wp option set blogname "$target_db" --url="$install_url"
		else

			echo "Creating new install with a blank DB..."

			# Multisite.
			if test '1' = "$(wp config get MULTISITE)"; then

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

	mkdir -p "$(dirname "$1")" && \
		wp db export - | gzip -9 -f > "$1.tar.gz"
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
	open -a Finder .
}

###
 # Run a command in a directory.
 #
 # @since Thursday, July 28, 2022
 #
 # shellcheck disable=SC3057
 ##
rid () {
	( cd "$1" && "${@:2}" )
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
 # Install WordPress.
 #
 # These uses the current directory name for the domain, title, etc.
 #
 # @since Feb 2, 2023
 ##
wpi () {

	if test -z "$1"; then

		echo "Please supply a title: wpi <title>"
		return 1
	fi

	wp core install --url="https://$(nwd).test" --title="$1" --admin_user=admin --admin_email="nobody@example.com" --admin_password="password" --skip-email
}

###
 # Same as wpi, but for multisite.
 #
 # @since Feb 2, 2023
 ##
wpimu () {

	if test -z "$1"; then
		echo "Please supply a title: wpimu <title>."
		return 1
	fi

	wp core multisite-install --title="$1" --admin_email="nobody@example.com" --url="https://$(nwd).test" --admin_password="password" --skip-email --skip-config
}

###
 # Reset the database.
 #
 # @since Feb 2, 2023
 ##
wpdbr () {
	wp db reset --yes
}

###
 # Reset DB and install WordPress.
 #
 # Pass --mu as "$2" to install as multisite.
 #
 # @since Feb 23, 2023
 ##
wpdbri () {

	if test -z "$1"; then

		echo "Please supply a title: $0 <title>"
		return 1
	fi

	mu='no'

	if [ "--mu" = "$2" ]; then
		mu='yes'
	fi

	if test ! -e "wp-config.php"; then

		echo "Please run where wp-config.php is."
		return 1;
	fi

	mkdir -p "dbs"

	echo "Exporting current db to dbs/$(wpblogname)..."
		wpdbx "dbs/$(wpblogname)"

	if [ "yes" = "$mu" ]; then

		wp config set WP_ALLOW_MULTISITE true --raw && \
			wpdbr && wpimu "$1" && wp rewrite flush

		return 0;
	fi

	wp config set WP_ALLOW_MULTISITE false --raw && \
		wpdbr && wpi "$1" &&wp rewrite flush

	return 0;
}

###
 # Update all the things.
 #
 # @since Apr 7, 2023
 ##
update () {
	brew update
}

###
 # Upgrade the things I usually want to upgrade.
 #
 # @since Apr 7, 2023
 #
 # @dependency in my-misc.zsh
 ##
upgrade () {

	brew upgrade gh
	brew upgrade n
	brew upgrade lazygit
}

###
 # Quietly do something in the background.
 #
 # @since Apr 7, 2023
 ##
quietly () {

	( ( # Quietly....

		eval "$1"

	) 1>&- 2>&- & )
}

###
 # Slugify a string.
 #
 # @since Apr 14, 2023
 ##
slugify () {

	# shellcheck disable=SC2018,SC2019
	echo "$1" | iconv -c -t ascii//TRANSLIT | sed -E 's/[~^]+//g' | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-+|-+$//g' | tr A-Z a-z
}

###
 # Delete .DS_Store in a folder (recursive).
 #
 # @since Jul 21, 2023
 ##
rmdstore () {

	dir="$1"

	if [ ! -d "$dir" ] || [ -L "$dir" ]; then

		echo "Sorry, but $dir does not exist (or it is a symlink)."
		return 1
	fi

	find "$dir" -name ".DS_Store" -delete

	killall Finder

	echo "Done cleaning $dir of .DS_Store files (recursively)."
}

###
 # Reset Finder to my default view.
 #
 # @since Jul 21, 2023
 # @since Sep 6, 2023 Change back to list view, just so much superior.
 ##
resetfinder () {

	rmdstore "$HOME"

	# Tell finder to use set view by default, see https://www.defaults-write.com/change-default-view-style-in-os-x-finder/
	defaults write com.apple.Finder FXPreferredViewStyle Nlsv

	killall Finder

	echo "Done resetting Finder default view."
}

###
 # Restart Finder.
 #
 # @since Jul 28, 2023
 ##
finderr () {

	killall Finder
	finder "$HOME"
}

###
 # Slugify the current branch.
 #
 # @since Aug 4, 2023
 #
 # shellcheck disable=SC2005
 ##
slugifyb () {
	echo "$(slugify "$(git b)")"
}

###
 # Slugify the current branch and copy to the clipboard.
 #
 # @since Aug 4, 2023
 ##
slugifycb () {
	slugifyb | pbcopy
}

###
 # Turn WP_DEBUG on or off.
 #
 # E.g.
 #    wpdebug on (default)
 #    wpdebug off
 #
 # @since Aug 15, 2023
 ##
wpdebug () {

	switch="$1"

	if [ "$switch" = 'off' ]; then
		switch="false"
	else
		switch="true"
	fi

	wp config set "WP_DEBUG" "$switch" --raw
}

###
 # Set the AffiliateWP License.
 #
 # E.g. affwpl pro
 # E.g. affwpl personal
 #
 # @since Aug 15, 2023
 ##
affwpl () {

	if [ 'personal' = "$1" ] || [ '1' = "$1" ]; then
		wp config set 'AFFWP_LICENSE' "personal"
		return 0
	fi

	if [ 'plus' = "$1" ] || [ '2' = "$1" ]; then
		wp config set 'AFFWP_LICENSE' "plus"
		return 0
	fi

	if [ 'pro' = "$1" ] || [ '3' = "$1" ]; then
		wp config set 'AFFWP_LICENSE' "pro"
		return 0
	fi

	echo "No license level set." && return 1
}

###
 # Turn multisite on or off.
 #
 # E.g. mu on
 # E.g. mu off (default)
 #
 # @since Aug 15, 2023
 ##
wpmu () {

	if [ 'on' = "$1" ]; then
		wp config set 'WP_ALLOW_MULTISITE' true --raw
	else
		wp config set 'WP_ALLOW_MULTISITE' false --raw
	fi
}

###
 # Turn WP Mail on and/or off.
 #
 # E.g.
 #     wpmail on
 #     wpmail off (default)
 #
 # @since Aug 15, 2023
 ##
wpmail () {

	if [ 'on' = "$1" ]; then
		wp config set 'MAIL' true --raw
	else
		wp config set 'MAIL' false --raw
	fi
}
