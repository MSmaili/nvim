#!/usr/bin/env bash
set -euo pipefail

# Parse flags
DRY_RUN=false
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

if $DRY_RUN; then
    echo "🔍 DRY RUN MODE - No changes will be made"
fi

echo "🚀 Setting up dotfiles..."

OS="$(uname -s)"
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

export DRY_RUN
source "$BASE_DIR/install/helpers/prompt.sh"

if [[ "$OS" == "Darwin" ]]; then
    DISTRO="macos"
elif [[ "$OS" == "Linux" ]]; then
    if command -v apt &>/dev/null; then
        DISTRO="ubuntu"
    elif command -v dnf &>/dev/null; then
        DISTRO="fedora"
    else
        echo "❌ Unsupported Linux distribution"
        echo "Supported: Ubuntu (apt), Fedora (dnf)"
        exit 1
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
    run_cmd bat cache --clear
else
    echo "bat not found, skipping cache clear"
fi


echo "✅ All done!"
