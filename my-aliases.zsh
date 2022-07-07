#!/bin/zsh

###
 # Aliases
 #
 # @since Thursday, 10/1/2020 Moved over from .config
 # @since Apr 19, 2022        Move to own plugin.
 ##
alias cat="bat"
alias edit="subl -n"
alias e="edit"
alias editzsh="subl -n ~/.zshrc"
alias editgit="subl -n ~/.gitconfig"
alias editssh="subl -n ~/.ssh/config"
alias nw='ttab -w' # New window.
alias nt='ttab ' # New tab.
alias c=clear
alias tower='gittower'
alias ntx="nt && x"
alias na="n auto" # Install the preferred version.
alias fakedata="fakedata --limit 1"
alias golive="ngrok http -host-header=rewrite $1:443"

# Easy composer commands.
alias cu="composer uninstall"
alias cis="composer install --prefer-source" # source install.
alias cid="composer install --prefer-dist" # dist install.
alias crd="composer uninstall && composer install --prefer-dist" # reinstall with dist.
alias crs="composer uninstall && composer install --prefer-source" # reinstall with source.
alias ccc="composer clearcache && composer global clearcache"

# Composer versions
alias c@2="composer self-update --2"
alias c@1="composer self-update --1"

# Fuzzy find at certain levels easily.
alias fdd="fd 2" # Two levels.
alias fd!="fd 10" # Deeper.
alias fd~="fd 50" # Super deep.

# Misc.
alias vim="vim -c 'startinsert'" # Start Vim in insert mode (mostly for commit writing).
alias repo="cd ~/Repos && fdd" # An easy way to get to a repo using my ffd command.
alias loc="cd ~/Sites/Local && fd && cd app/public || true" # Quick way to get to a site
alias site="cd ~/Sites && fd || true"
alias antigenfd="cd ~/.antigen/bundles/aubreypwd && fd" # An easy way to get to a bundle.
alias locals="cd ~/Sites/Local && fd 3" # An easy way to get to a local.
alias high='highlight -O ansi'

	# Installs (NPM)
alias npmai="n auto && npm i"
alias npmaci="n auto && npm ci"

# Build (NPM)
alias npmcib="npmaci && npmrb && b"
alias npmib="npmai && npmrb && b"
alias npmrb="npm run build && b"

# Dev (NPM)
alias npmcid="npmaci && npmrd"
alias npmid="npmai && npmrd"
alias npmibd="npmai && npmrb && npmrd"
alias npmrd="npm run dev || npm run watch || npm run start || true"

# Homebrew
alias brewd="brew bundle dump --file=$HOME/.Brewfile --verbose --all --describe --force --no-lock" # Dump what's installed to my Brewfile

# Sounds
alias bell="tput bel"
alias beep="bell"
alias b="bell"

# diff folders
alias diffd="diff -rq" # Diff a directory.

# vcsh
alias pub='vcsh pub'
alias priv='vcsh priv'

# Misc
alias matrix='cmatrix'

# WP-CLI
alias wpeach='wp site list --field=url | xargs -n1 -I % wp --url=%' # On each subsite, run a command.
alias wpdbn="wp config get DB_NAME" # What is the database name

# xattr
alias clearatts="xattr -cr"

# Valet
alias db='mycli -u root -h 127.0.0.1'
alias dbs="mysql -u root -e 'show databases;'"

# Finder
alias finder='open -F -a Finder' # Open Finder but remember the window size when you open.

# DNS
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'

# AwesomeMotive / AffiliateWP
alias affwp:build='composer install || composer update && na && npm ci || npm i && npm run build'

# PHP
alias php5="/opt/homebrew/Cellar/php@5.6/5.6.40_4/bin/php"
alias php7="/opt/homebrew/Cellar/php@7.4/7.4.30/bin/php"
alias php8="/opt/homebrew/Cellar/php/8.1.7/bin/php"
alias phpv="php -r 'echo phpversion() . \"\n\";' | sed 's/ *$//g'" # Get just the version number.

	# PHP switching
	alias php@5="brew unlink php && brew unlink php@5.6 && brew link --overwrite php@5.6 --force && composer global update && php --version"
	alias php@7="brew unlink php && brew unlink php@7.4 && brew link --overwrite php@7.4 --force && composer global update && php --version"
	alias php@8="brew unlink php && brew unlink php@8.1 && brew link --overwrite php@8.1 --force && composer global update && php --version"
	alias php@most="php@8" # The latest PHP version.

	# Switch valet to version, but keep system at 8.
	alias valet@7="php@most && unlink $HOME/.config/valet/valet.sock || true && valet use php@7.4 --force && php@most"
	alias valet@8="php@most && unlink $HOME/.config/valet/valet.sock || true && valet use php@8.1 --force && php@most"
	alias valetv="basename $(readlink $HOME/.config/valet/valet.sock)" # A way to see what version valet is running at.

# PHP -S
alias serve="php -S localhost:8000"
alias serve5="php5 -S localhost:8000"
alias serve7="php7 -S localhost:8000"
alias serve8="php8 -S localhost:8000"

	# Multisite
	alias servemu="php -S mu.localhost:8000"
	alias serve5mu="php5 -S mu.localhost:8000"
	alias serve7mu="php7 -S mu.localhost:8000"
	alias serve8mu="php8 -S mu.localhost:8000"

# Screens
alias screens="screen -ls"
alias ns="screen" # New screen
alias nS="screen -S" # New screen by name

# Antigen
alias	plugin="cd $HOME/.antigen/bundles/aubreypwd && fd"