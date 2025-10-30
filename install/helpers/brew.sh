#!/usr/bin/env bash
set -e

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ensure_brew_installed() {
    if ! command -v brew &>/dev/null; then
        echo "📦 Installing Homebrew..."
        echo "⚠️ This will download and execute Homebrew installer"
        read -p "Continue? (y/N): " -n 1 -r
        echo
        [[ ! $REPLY =~ ^[Yy]$ ]] && return 1

        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
}

brew_bundle_install() {
    local file="$1"
    echo "📋 Installing packages from Brewfile..."
    brew bundle --file="$file"
}
