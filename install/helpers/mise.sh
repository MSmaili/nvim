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

    echo "📘 Installing Go and Node via mise..."
    mise use -g go@latest
    mise use -g node@lts
    mise use -g rust@stable
    # mise use -g bun@latest
    mise use -g java@21
}
