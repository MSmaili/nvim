#!/usr/bin/env bash
set -e

install_zsh() {
    echo "🐚 Setting up Zsh configuration..."

    # Check if zsh is installed
    if ! has zsh; then
        echo "Zsh is not installed. Please install it first."
        return 1
    fi

    # Get the path to zsh
    ZSH_PATH=$(which zsh)

    # Check if zsh is already the default shell
    if [ "$SHELL" = "$ZSH_PATH" ]; then
        echo "Zsh is already your default shell."
        exit 0
    fi

    # Add zsh to /etc/shells if not already there
    if ! grep -q "^$ZSH_PATH$" /etc/shells; then
        run_cmd sudo tee -a /etc/shells >/dev/null <<< "$ZSH_PATH"
    fi

    # Change the default shell to zsh
    run_cmd chsh -s "$ZSH_PATH"

    echo "Zsh configuration complete!"
}
