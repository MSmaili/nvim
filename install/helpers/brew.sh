#!/usr/bin/env bash
set -e

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$BASE_DIR/prompt.sh"

ensure_brew_installed() {
    if ! has brew; then
        echo "📦 Installing Homebrew..."
        echo "⚠️ This will download and execute Homebrew installer"

        if ! ask_yes_no "Continue?"; then
            skip_with_message "Skipping Homebrew installation."
            return 0
        fi

        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
}

brew_bundle_install() {
    local file="$1"
    if has brew; then
        echo "📋 Installing packages from Brewfile..."
        run_cmd brew bundle --file="$file"
    else
        skip_with_message "Skipping Brewfile installation (Homebrew not available)."
    fi
}
