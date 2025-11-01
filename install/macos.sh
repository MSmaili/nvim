#!/usr/bin/env bash
set -e

echo "🎩 Macos setup..."
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$BASE_DIR/helpers/brew.sh"

ensure_brew_installed
echo $BASE_DIR
brew_bundle_install "$BASE_DIR/Brewfile"

bash "$BASE_DIR/../common.sh"
