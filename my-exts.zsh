#!/bin/bash

###
 # My File Extension Associations
 #
 # @since Jul 14, 2023
 ##

( (

	# Sublime Text 4: com.sublimetext.4
	duti -s com.sublimetext.4 .php all
	duti -s com.sublimetext.4 .js all
	duti -s com.sublimetext.4 .jsx all
	duti -s com.sublimetext.4 .html all
	duti -s com.sublimetext.4 .css all
	duti -s com.sublimetext.4 .scss all
	duti -s com.sublimetext.4 .sass all
	duti -s com.sublimetext.4 .tx all
	duti -s com.sublimetext.4 .sublime-project all
	duti -s com.sublimetext.4 .sublime-workspace all
	duti -s com.sublimetext.4 .json all

) 1>&- 2>&- & )