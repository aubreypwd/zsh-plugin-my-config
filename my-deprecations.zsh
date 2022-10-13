#!/bin/bash

###
 # Instruct someone to use a different command.
 #
 # @since Wednesday, July 27, 2022
 ##
useinstead () {

	echo "Use [$1] instead, this command has been deprecated. $2"
	return 1
}

###
 # Deprecated Notice.
 #
 # @since Oct 13, 2022
 ##
deprecated () {

	echo "This command has been deprecated, and is no longer in use. $1"
	return 1
}

###
 # Aliases
 ##
alias valet@7="useinstead 'valet isolate php@7.x'"
alias valet@8="useinstead 'valet isolate php@8.x'"
alias valetv="deprecated"
alias valets="useinstead 'valet share'"
alias wpdbsw="deprecated"
alias wpci="deprecated"
alias __affwp_sdbi="deprecated"
alias watchfext="deprecated"
alias watchf-ext="deprecated"
alias risd="deprecated"
alias hide-in-dock="useinstead 'hideindock'"
alias show-in-dock="useinstead 'showindock'"
alias subl.="useinstead 'sublop'"

###
 # Functions
 ##
vu () { useinstead "valet isolate php@x.x"; }
watchf () { useinstead "watchfext"; }
plugin () { useinstead "gotoplugin"; }
iwpdebug () { useinstead "wpdebugi"; }
lwpclisock () { deprecated ''; }
antigendir () { deprecated ''; }