#!/usr/bin/env bash
set -e

install_zsh() {
    echo "🐚 Setting up Zsh configuration..."

    # Check if zsh is installed
    if ! command -v zsh &>/dev/null; then
        echo "❌ Zsh is not installed. Please install it first."
        return 1
    fi

    # Set Zsh as default shell if not already
    if [ "$SHELL" != "$(which zsh)" ]; then
        echo "🔧 Setting Zsh as default shell..."
        chsh -s "$(which zsh)" || echo "⚠️ Unable to change default shell automatically. Please run 'chsh -s $(which zsh)'."
    fi

    echo "✅ Zsh configuration complete!"
}
