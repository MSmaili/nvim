#!/usr/bin/env bash
set -e

echo "🦋 Arch setup..."
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo pacman -Sy --noconfirm git curl stow zsh tmux

bash "$BASE_DIR/common.sh"
