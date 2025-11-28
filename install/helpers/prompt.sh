#!/usr/bin/env bash

# Run command with dry-run support
run_cmd() {
    if ${DRY_RUN:-false}; then
        echo "[DRY RUN] $*"
    else
        "$@"
    fi
}

# Reusable prompt function that returns 0 for yes, 1 for no
# Usage: if ask_yes_no "Install something?"; then ... fi
ask_yes_no() {
    local message="$1"
    local default="${2:-N}"  # Default to N if not specified

    if ${DRY_RUN:-false}; then
        echo "[DRY RUN] Would prompt: $message"
        return 0
    fi

    if [[ "$default" == "Y" ]]; then
        local prompt="$message (Y/n): "
    else
        local prompt="$message (y/N): "
    fi

    read -p "$prompt" -n 1 -r
    echo

    if [[ "$default" == "Y" ]]; then
        [[ $REPLY =~ ^[Nn]$ ]] && return 1 || return 0
    else
        [[ $REPLY =~ ^[Yy]$ ]] && return 0 || return 1
    fi
}

# Skip function with message
skip_with_message() {
    local message="$1"
    echo "⏭️ $message"
    return 0
}

# Define if it has command
# usage if has bat; then ... fi
has() { command -v "$1" >/dev/null 2>&1; }

# if path exist by default or -f Or file -d for directory
exists() {
    local flag path
    if [[ "$1" == -* ]]; then
        flag="$1"
        path="$2"
    else
        flag="-e"
        path="$1"
    fi

    case "$flag" in
        -e) [[ -e "$path" ]] ;;
        -f) [[ -f "$path" ]] ;;
        -d) [[ -d "$path" ]] ;;
        -L) [[ -L "$path" ]] ;;
        *) echo "Unknown flag '$flag'" >&2; return 2 ;;
    esac
}

has_file() { exists -f "$1"; }
has_dir()  { exists -d "$1"; }
