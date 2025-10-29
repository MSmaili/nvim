#!/usr/bin/env bash
set -e

echo "🎩 Fedora setup..."
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo dnf upgrade --refresh
sudo dnf copr enable scottames/ghostty

sudo dnf install -y git curl stow zsh tmux neovim ghostty

bash "$BASE_DIR/common.sh"
