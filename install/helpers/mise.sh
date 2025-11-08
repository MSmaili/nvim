#!/usr/bin/env bash
set -e

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$BASE_DIR/prompt.sh"

install_mise_languages() {
    if ! has mise; then
        echo "📦 Installing mise..."
        echo "⚠️ This will download and execute the mise installer"
        curl -fsSL https://mise.run | sh
        export PATH="$HOME/.local/bin:$PATH"
    else
        shell_name=$(ps -p $$ -o comm= 2>/dev/null | tail -n1 || echo bash)
        shell_name=$(basename "$shell_name")

        eval "$(mise activate "$shell_name")"

        if has_file "$HOME/.config/mise/config.toml"; then
            if ! mise trust --check "$HOME/.config/mise/config.toml" &>/dev/null; then
                echo "🔐 Trusting mise config..."
                mise trust "$HOME/.config/mise/config.toml" >/dev/null 2>&1
            fi
        fi
    fi

    echo "Installing languages defined in mise config..."
    mise install

    echo "✅ mise languages installation complete."
}

