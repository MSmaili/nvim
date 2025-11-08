#!/usr/bin/env bash

# Reusable prompt function that returns 0 for yes, 1 for no
# Usage: if ask_yes_no "Install something?"; then ... fi
ask_yes_no() {
    local message="$1"
    local default="${2:-N}"  # Default to N if not specified
    
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
