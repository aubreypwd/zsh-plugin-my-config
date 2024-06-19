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
 # @since May 17, 2024 Renamed to affwpbuildr
 ##
affwpbuildr () {

	if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then

		echo "Usage: affwpbuildr <source zip file> <version> <sub-directory to zip>"
		echo "Eg.: affwpbuildr affiliate-wp-master.zip '2.24.2' 'affiliate-wp'"

		return 1
	fi

	if [ ! -e "./$1" ]; then
		
		echo "./$1 does not exist, download it from https://github.com/awesomemotive/affiliate-wp"
		return 1
	fi

	if [ -d "./${1//.zip/}" ]; then

		echo "Removing directory ./${1//.zip/} so we can unzip $1..."

		read "?Press [Enter] to continue or [CTRL+C] to exit now..."

		trash "./${1//.zip/}" || rm -Rf "./${1//.zip/}"
	fi

	unzip -o -qq "$1"

	if [ ! -d "./${1//.zip/}/$3" ]; then
		
		echo "./${1//.zip/}/$3 does not exist, try again with the correct sub-folder."
		return 1
	fi

	if [ -e "./$2.zip" ]; then
			
		echo "Deleting existing ZIP ./$2.zip so we can create a new one..."

		read "?Press [Enter] to continue or [CTRL+C] to exit now..."
		
		trash "./$2.zip" || rm -Rf "./$2.zip"
	fi

	echo "Creating ZIP ./$2.zip..."

	cd "./${1//.zip/}" && \
		zip -r -q -9 "../$2.zip" "$3" -x "*.DS_Store" || cd .. && \
		cd ..

	zipinfo *.zip > zipinfo.txt && \
		cat zipinfo.txt | bat zipinfo.txt

	echo "Delete ./${1//.zip/} and ./$1 ???"
	read "?Press [Enter] to continue or [CTRL+C] to exit now..."

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
