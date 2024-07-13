#!/bin/sh

###
 # My Mac Defaults
 #
 # @since Tuesday, April 19, 2022
 ##

startup-mac-defaults () {

	# Misc
	defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
	defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
	defaults write com.apple.desktopservices DSDontWriteNetworkStores true
	defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
	defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

	# Disable disk image verification
	defaults write com.apple.frameworks.diskimages skip-verify -bool true
	defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
	defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

	# Automatically open a new Finder window when a volume is mounted
	defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
	defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
	defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

	# Keyboard
	defaults write com.apple.loginwindow DisableScreenLockImmediate -bool yes # Disable the lock key above the delete key.

	# Screenshots
	defaults write com.apple.screencapture type jpg # Take jpg screenshots.
	defaults write com.apple.screencapture location "$HOME/Pictures/Screenshots/Autosaved"

	defaults write com.googlecode.iterm2 "Secure Input" 0 # Tell iterm2 to allow non-secure input for escape

	# Sublime Text
	defaults write com.sublimetext.4 ApplePressAndHoldEnabled -bool false # https://www.sublimetext.com/docs/vintage.html#mac
	defaults write com.sublimetext ApplePressAndHoldEnabled -bool false # https://www.sublimetext.com/docs/vintage.html#mac

	# TextEdit
	defaults write com.apple.TextEdit SmartQuotes -bool false
	defaults write com.apple.TextEdit SmartDashes -bool false

	# Dock
	defaults write com.apple.dock springboard-columns -int 7 # Launchpad Grid
	defaults write com.apple.dock springboard-rows -int 7 # Launchpad Grid
	defaults write com.apple.Dock autohide-delay -float 0 # Show dock after X seconds, e.g. 99 co.
	defaults write com.apple.dock autohide-time-modifier -int 1 # Also a similar setting.
	defaults write com.apple.dock showhidden -bool false # When Apps are hidden, dim them in Dock.
	defaults write com.apple.dock static-only -bool false # Only show running apps in Dock (when set to true)
	defaults write com.apple.dock show-recent-count -int 2 # Show only X recent app by default.
	defaults write com.apple.dock workspaces-edge-delay -float 0.4 # Switch to new space quicker.

	# Finder
	defaults write com.apple.Finder QuitMenuItem 1 # Add Quit to Finder
	defaults write com.apple.Finder FXPreferredViewStyle Nlsv # Tell Finder what view style to use, see https://www.defaults-write.com/change-default-view-style-in-os-x-finder/
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false # Disable the warning when changing a file extension
	defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
	defaults write com.apple.finder CreateDesktop false # Desktop icons.
	defaults write NSGlobalDomain "NSToolbarTitleViewRolloverDelay" -float "0" # When hovering over the folder in finder, show the icon immediately.

	# Safari
	defaults write NSGlobalDomain WebKitDebugDeveloperExtrasEnabled -bool YES # Allow inspecting the web inspector.
}

