#!/usr/bin/env bash
set -e

install_zsh() {
  echo "🐚 Setting up Zsh configuration..."

  # Check if zsh is installed
  if ! command -v zsh &>/dev/null; then
    echo "❌ Zsh is not installed. Please install it first."
    return 1
  fi

  # Skip if already configured
  if [[ -d "$HOME/.oh-my-zsh" ]] && [[ "$SHELL" == "$(which zsh)" ]]; then
    echo "✅ Zsh already configured, skipping..."
    return 0
  fi

  # Set Zsh as default shell if not already
  if [ "$SHELL" != "$(which zsh)" ]; then
    echo "🔧 Setting Zsh as default shell..."
    chsh -s "$(which zsh)" || echo "⚠️ Unable to change default shell automatically. Please run 'chsh -s $(which zsh)'."
  fi

  # Install Oh My Zsh if missing
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "📦 Installing Oh My Zsh..."
    echo "⚠️ This will download and execute Oh My Zsh installer"
    read -p "Continue? (y/N): " -n 1 -r
    echo
    [[ ! $REPLY =~ ^[Yy]$ ]] && return 1

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  fi

  test() {
    # Install Powerlevel10k theme
    local ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
    if [[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]]; then
      echo "⚡ Installing Powerlevel10k..."
      git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
    fi

    # Install useful plugins
    local plugins_dir="$ZSH_CUSTOM/plugins"
    mkdir -p "$plugins_dir"

    # Define plugins as simple arrays
    local plugin_names=("zsh-autosuggestions" "zsh-syntax-highlighting")
    local plugin_urls=(
      "https://github.com/zsh-users/zsh-autosuggestions"
      "https://github.com/zsh-users/zsh-syntax-highlighting"
    )

    for i in "${!plugin_names[@]}"; do
      local plugin="${plugin_names[$i]}"
      local url="${plugin_urls[$i]}"

      if [[ ! -d "$plugins_dir/$plugin" ]]; then
        echo "🔌 Installing $plugin..."
        git clone "$url" "$plugins_dir/$plugin"
      fi
    done
  }
  test

  echo "✅ Zsh configuration complete!"
}
