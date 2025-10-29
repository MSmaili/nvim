#!/usr/bin/env bash
set -e

echo "🐧 Ubuntu setup..."
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo apt update
sudo apt install -y git curl stow zsh tmux

bash "$BASE_DIR/common.sh"
