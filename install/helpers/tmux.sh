#!/usr/bin/env bash
set -e

install_tmux_plugins() {
    local tpm_dir="$HOME/.config/tmux/plugins/tpm"
    if ! has_dir "$tpm_dir"; then
        echo "🔧 Installing Tmux Plugin Manager..."
        run_cmd git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
    fi
}
