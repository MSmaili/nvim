#!/usr/bin/env bash
set -euo pipefail
DRY_RUN=true

echo "🚀 Setting up dotfiles..."

OS="$(uname -s)"
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

echo $BASE_DIR
source "$BASE_DIR/install/helpers/prompt.sh"

if [[ "$OS" == "Darwin" ]]; then
    DISTRO="macos"
elif [[ "$OS" == "Linux" ]]; then
    if command -v apt &>/dev/null; then
        DISTRO="ubuntu"
    elif command -v dnf &>/dev/null; then
        DISTRO="fedora"
    elif command -v pacman &>/dev/null; then
        DISTRO="arch"
    fi
else
    echo "❌ Unsupported OS"
    exit 1
fi


if [[ -f "$BASE_DIR/install/$DISTRO.sh" ]]; then
    source "$BASE_DIR/install/$DISTRO.sh"
fi

if has bat; then
    echo "Clearing bat cache..."
    bat cache --clear
else
    echo "bat not found, skipping cache clear"
fi


echo "✅ All done!"
