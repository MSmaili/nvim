#!/usr/bin/env bash
set -euo pipefail

echo "🧩 Applying macOS system settings..."

# Ensure running on macOS
[[ "$OSTYPE" == "darwin"* ]] || exit 0

###############################################################################
# Keyboard & Input
###############################################################################

# Disable input source switching with Ctrl+Space (conflicts with tmux)
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 '<dict><key>enabled</key><false/></dict>'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 61 '<dict><key>enabled</key><false/></dict>'

# Key repeat improvements
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

###############################################################################
# Finder
###############################################################################
# Show hidden files by default
# defaults write com.apple.finder AppleShowAllFiles -bool true

# Show path bar and status bar
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# Search current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

###############################################################################
# Dock
###############################################################################

# Auto-hide Dock and speed up hide/show delay
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.3

# Minimize windows into app icon
defaults write com.apple.dock minimize-to-application -bool true


###############################################################################
# Tracpad
###############################################################################
# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable "natural" (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

###############################################################################
# Apply changes
###############################################################################

killall Dock Finder SystemUIServer &>/dev/null || true

echo "✅ macOS settings applied!"
