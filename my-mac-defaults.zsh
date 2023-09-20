#!/bin/sh

###
 # My Mac Defaults
 #
 # @since Tuesday, April 19, 2022
 ##

() {

	if [[ $(pwd) != "$HOME" ]]; then
		return
	fi

	###
	 # macOS Default Flags
	 #
	 # @since Thursday, 10/1/2020
	 ##
	defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
	defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
	defaults write com.apple.TextEdit SmartQuotes -bool false
	defaults write com.apple.TextEdit SmartDashes -bool false
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
	defaults write com.apple.screencapture location "$HOME/Pictures/Screenshots"
	defaults write com.apple.desktopservices DSDontWriteNetworkStores true
	defaults write com.apple.Finder QuitMenuItem 1 # Add quit to Finder
	defaults write com.apple.dock springboard-columns -int 7
	defaults write com.apple.dock springboard-rows -int 7 # Launchpad Grid
	defaults write com.apple.Dock autohide-delay -float 0 # Show dock after X seconds, e.g. 99 co.
	defaults write com.apple.dock autohide-time-modifier -int 1 # Also a similar setting.
	defaults write com.apple.dock showhidden -bool false # When Apps are hidden, dim them in Dock.
	defaults write com.apple.dock static-only -bool false # Only show running apps in Dock (when set to true)
	defaults write com.googlecode.iterm2 "Secure Input" 0 # Tell iterm2 to allow non-secure input for escape
	defaults write com.apple.screencapture type jpg # Take jpg screenshots.
	defaults write com.apple.dock show-recent-count -int 2 # Show only X recent app by default.
	defaults write com.apple.finder CreateDesktop true # Desktop icons.
	defaults write com.sublimetext.4 ApplePressAndHoldEnabled -bool false # https://www.sublimetext.com/docs/vintage.html#mac
	defaults write com.sublimetext ApplePressAndHoldEnabled -bool false # https://www.sublimetext.com/docs/vintage.html#mac
	defaults write NSGlobalDomain "NSToolbarTitleViewRolloverDelay" -float "0" # When hovering over the folder in finder, show the icon immediately.

} &> /dev/null &!