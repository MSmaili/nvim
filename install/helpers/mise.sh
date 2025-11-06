#!/usr/bin/env bash
set -e

install_mise_languages() {
    if ! command -v mise &>/dev/null; then
        echo "📦 Installing mise..."
        echo "⚠️ This will download and execute the mise installer"
        read -p "Continue? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "❌ Aborted."
            return 1
        fi
        curl -fsSL https://mise.run | sh
        export PATH="$HOME/.local/bin:$PATH"
    fi

    if command -v mise &>/dev/null; then
        shell_name=$(ps -p $$ -o comm= 2>/dev/null | tail -n1 || echo bash)
        shell_name=$(basename "$shell_name")

        eval "$(mise activate "$shell_name")"

        if [ -f "$HOME/.config/mise/config.toml" ]; then
            if ! mise trust --check "$HOME/.config/mise/config.toml" &>/dev/null; then
                echo "🔐 Trusting mise config..."
                mise trust "$HOME/.config/mise/config.toml" >/dev/null 2>&1
            fi
        fi
    fi

    echo "📘 Installing languages defined in mise config..."
    mise install

    echo "✅ mise languages installation complete."
}

