#!/usr/bin/env bash
set -e

install_mise_languages() {
    # Ensure PATH includes ~/.local/bin
    export PATH="$HOME/.local/bin:$PATH"

    # Install mise if missing
    if ! command -v mise &>/dev/null; then
        echo "📦 Installing mise..."
        echo "⚠️ This will download and execute the mise installer"
        read -p "Continue? (y/N): " -n 1 -r
        echo
        [[ ! $REPLY =~ ^[Yy]$ ]] && return 1

        curl https://mise.run | sh
        export PATH="$HOME/.local/bin:$PATH"
    fi

    # Initialize mise for zsh
    if [ -x ~/.local/bin/mise ]; then
        eval "$(~/.local/bin/mise activate zsh)"

        # Trust config.toml (only if not already trusted)
        if [ -f "$HOME/.config/mise/config.toml" ]; then
            if ! mise trusted "$HOME/.config/mise/config.toml" &>/dev/null; then
                echo "🔐 Trusting mise config..."
                mise trust "$HOME/.config/mise/config.toml" >/dev/null 2>&1
            fi
        fi
    fi

    echo "📘 Installing languages defined in mise config..."
    mise install
}

