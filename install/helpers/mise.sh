#!/usr/bin/env bash
set -e

install_mise_languages() {
    if ! command -v mise &>/dev/null; then
        echo "📦 Installing mise..."
        echo "⚠️ This will download and execute mise installer"
        read -p "Continue? (y/N): " -n 1 -r
        echo
        [[ ! $REPLY =~ ^[Yy]$ ]] && return 1

        curl https://mise.run | sh
        export PATH="$HOME/.local/bin:$PATH"
    fi

    echo "📘 Installing languages defined in ~/.config/mise/config.yaml..."
    mise install
}
