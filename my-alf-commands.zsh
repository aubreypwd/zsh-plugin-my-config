#!/bin/sh

###
 # My AffiliateWP Commands
 #
 # @since Apr 17, 2024
 ##

###
 # AffiliateWP: Build a Release ZIP
 # 
 # 1. First download a monorepo zip from AwesomeMotive/AffiliateWP
 # 2. Run <alfzipr affiliate-wp-master.zip '2.24.2' 'affiliate-wp'> which will create affiliatewp-2.24.2.zip from the affiliate-wp directory.
 #
 # @usage alfzipr <source zip file> <version> <directory to zip>
 #
 # @since Apr 17, 2024
 # @since Apr 26, 2024 Updated to create affiliate-wp-x.x.x file not affiliatewp-x.x.x file.
 # @since May 17, 2024 Renamed to affwpzipr
 ##
affwpzipr () {

	if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then

		echo "Usage: alfzr <source zip file> <version> <sub-directory to zip>"
		echo "Eg.: alfzr affiliate-wp-master.zip '2.24.2' 'affiliate-wp'"

		return 1
	fi

	if [ ! -e "./$1" ]; then
		
		echo "./$1 does not exist, download it from https://github.com/awesomemotive/affiliate-wp"
		
		return 1
	fi

	if [ -d "./${1//.zip/}" ]; then

		echo "Removing directory ./${1//.zip/} so we can unzip $1..."

		read "?Press any key to continue or CTRL+c to exit now..."

		rm -Rf "./${1//.zip/}"
	fi

	unzip -q "./$1"

	if [ ! -d "./${1//.zip/}/$3" ]; then
		
		echo "./${1//.zip/}/$3 does not exist, try again with the correct sub-folder."
		
		return 1
	fi

	if [ -e "./affiliate-wp-$2.zip" ]; then
			echo "Deleting existing ZIP ./affiliate-wp-$2.zip so we can create a new one..."

			read "?Press any key to continue or CTRL+c to exit now..."
			
			rm -f "./affiliate-wp-$2.zip"
	fi

	cd "./${1//.zip/}" && \
		zip -rq "../affiliate-wp-$2.zip" "$3" -x "*.DS_Store" && \
		cd ..

	zipinfo *.zip > zipinfo.txt && \
		cat zipinfo.txt

	echo "Delete ./${1//.zip/} and ./$1?"
	read "?Press any key to continue or CTRL+c to exit now..."

	trash "./${1//.zip/}" || rm -Rf "./${1//.zip/}" 
	trash "./$1" || rm -Rf "./$1"
}

###
 # AffiliateWP: Update @since AFFWPN with a version number.
 # 
 # @usage affwpn <version>
 #
 # @since Apr 26, 2024
 ##
affwpn () {

	if [ -z "$1" ]; then

		echo "Usage: affwpn <version>"
		echo "Eg.: affwpn '2.24.2'"

		return 1
	fi

	R1='s/(@since\s*)(AFFWPN)/${1}'
	R2="$1"
	R3='/g'

	find . -type d \( -name "vendor" -o -name "node_modules" -o -name "dist" \) -prune -o -type f \( -name "*.php" -o -name "*.js" \) -print0 | xargs -0 perl -pi -e "$R1$R2$R3"
}

###
 # Create a new AffiliateWP DEV Site.
 # 
 # @usage affwpd <directory-name>
 #
 # @since May 17, 2024
 ##
affwpnd () {

	if [ "Valet" != "$(nwd)" ]; then
		
		echo "You must run this in ~/Sites/Valet."
		return 1;
	fi
	
	PWD="$(pwd)"
	
	USAGE="Usage: affwpndev <new-directory>"
	
	DEV_SITE_PATH="$HOME/Sites/Valet/affiliatewp-dev"
	DEV_SITE_DB="$DEV_SITE_PATH/dbs/affiliatewp-dev.tar.gz"
	DEV_SITE_DOMAIN='affiliatewp-dev.test'

	if [ ! -e "$DEV_SITE_PATH" ]; then
		
		echo "Cannot find $DEV_SITE_PATH ..."
		return 1
	fi

	if [ ! -e "$DEV_SITE_DB" ]; then

		echo "Cannot find $DEV_SITE_DB ..."
		return 1
	fi

	NEW_DIR="affiliatewp-$1"

	if [ -z "$NEW_DIR" ]; then

		echo "\$1 should be set to a directory name.";
		echo "$USAGE"

		return 1
	fi

	if [ -d "./$NEW_DIR" ]; then

		echo "Unable to make ./$NEW_DIR, the directory already exists."
		return 1
	fi

	mkdir -p "$1"

	if [ ! -d "./$DIR" ]; then

		echo "Unable to make ./$NEW_DIR for an unknown reason."
		return 1
	fi

	echo "Clearing out $DEV_SITE_PATH/wp-content/uploads/..."
		trash -Rf "$DEV_SITE_PATH/wp-content/uploads"
		mkdir -p "$DEV_SITE_PATH/wp-content/uploads"

	echo "Removing un-necessary files & folders from $DEV_SITE_PATH/wp-content/* ..."
		trash -Rf "$DEV_SITE_PATH/wp-content/upgrade-temp-backup"
		trash -Rf "$DEV_SITE_PATH/wp-content/upgrade"
		trash -Rf "$DEV_SITE_PATH/wp-content/debug.log"

	echo "Optimzing $DEV_SITE_PATH/wp-content/plugins (AffiliateWP monorepo) before we copy..."
		git -C "$DEV_SITE_PATH/wp-content/plugins" fetch --all
		git -C "$DEV_SITE_PATH/wp-content/plugins" gc --prune=now --aggressive --auto

	echo "Copying $DEV_SITE_PATH/ to ./$NEW_DIR/ ..."
		
		rsync -az --info=progress2 --info=name0 --no-i-r --inplace \
				"$DEV_SITE_PATH/" "./$NEW_DIR/" \
						|| return 1

	wp db create --path="./$NEW_DIR" || wp db reset --yes --path="./$NEW_DIR"

	wp core install --url="http://$(nwd).test" \
		--admin_user=admin \
		--admin_email="nobody@example.com" \
		--admin_password=password \
		--title="$(nwd)" \
		--path="./$NEW_DIR" \
			|| return 1

	wp core update --force --path="./$NEW_DIR/" || return 1

	gzip -c -d "$DEV_SITE_DB" | wp db import --path="./$NEW_DIR/" -  && \
		wp search-replace "$DEV_SITE_DOMAIN" "$(nwd).test" --all-tables \
			--path="./$NEW_DIR/"
	
	cd "./$NEW_DIR"
}