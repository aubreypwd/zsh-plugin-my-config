#!/bin/bash

###
 # Instruct someone to use a different command.
 #
 # @since Wednesday, July 27, 2022
 ##
renamed () {

	echo "Use [$1] instead, this command has was renamed. $2"
	return 1
}

###
 # Deprecated Notice.
 #
 # @since Oct 13, 2022
 ##
deprecated () {

	echo "This command has been deprecated, and is no longer in usable."
	return 1
}

###
 # Aliases
 ##
alias valet@7="renamed 'valet isolate php@7.x'"
alias valet@8="renamed 'valet isolate php@8.x'"
alias valetv="deprecated"
alias valets="renamed 'valet share'"
alias wpdbsw="deprecated"
alias wpci="deprecated"
alias __affwp_sdbi="deprecated"
alias watchfext="deprecated"
alias watchf-ext="deprecated"
alias risd="deprecated"
alias hide-in-dock="renamed 'hideindock'"
alias show-in-dock="renamed 'showindock'"
alias subl.="renamed 'sublop'"

###
 # Renamed.
 ##
vu () { renamed "valet isolate php@x.x"; }
watchf () { renamed "watchfext"; }
plugin () { renamed "gotoplugin"; }
iwpdebug () { renamed "wpdebugi"; }
checkmyrepos () { renamed 'check-repos'; }

###
 # deprecated.
 ##
lwpclisock () { deprecated; }
antigendir () { deprecated; }