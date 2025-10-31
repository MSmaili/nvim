#!/usr/bin/env bash
set -e

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$BASE_DIR/helpers/zsh.sh"
source "$BASE_DIR/helpers/tmux.sh"
source "$BASE_DIR/helpers/mise.sh"

mkdir -p ~/.config/zsh ~/.config/tmux

install_zsh
install_tmux_plugins
install_mise_languages

if command -v stow &>/dev/null; then
    echo "🔗 Linking dotfiles..."
    cd "$BASE_DIR/.."
    # Stow everything except ignored files (see .stow-local-ignore)
    stow -vSt "$HOME" . 2>/dev/null || echo "⚠️ Some files already linked"
else
    echo "⚠️ stow not installed, skipping linking."
fi

echo "Sourcing fzf keybinding"
source <(fzf --zsh)


echo "✅ Common setup complete!"
