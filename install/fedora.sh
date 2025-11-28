#!/usr/bin/env bash
set -e

echo "🎩 Fedora setup..."
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$BASE_DIR/helpers/prompt.sh"

run_cmd sudo dnf upgrade --refresh
run_cmd sudo dnf copr enable scottames/ghostty
run_cmd sudo dnf copr enable dejan/lazygit

run_cmd sudo dnf install -y git curl stow zsh tmux neovim ghostty git-delta fzf lazygit

bash "$BASE_DIR/common.sh"
