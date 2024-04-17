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
 ##
alfzipr () {

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

	if [ -e "./affiliatewp-$2.zip" ]; then
			echo "Deleting existing ZIP ./affiliatewp-$2.zip so we can create a new one..."

			read "?Press any key to continue or CTRL+c to exit now..."
			
			rm -f "./affiliatewp-$2.zip"
	fi

	cd "./${1//.zip/}" && \
		zip -rq "../affiliatewp-$2.zip" "$3" -x "*.DS_Store" && \
		cd ..

	echo "Delete ./${1//.zip/} and ./$1?"
	read "?Press any key to continue or CTRL+c to exit now..."

	trash "./${1//.zip/}" || rm -Rf "./${1//.zip/}" 
	trash "./$1" || rm -Rf "./$1"
}