#!/bin/bash

set -e

echo "Installing dotfiles dependencies..."

# Install Homebrew if not present
if ! command -v brew >/dev/null 2>&1; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install essential tools
echo "Installing CLI tools..."
cli_tools=(fzf fd bat lazygit lazydocker tmux neovim stow tree-sitter)
for tool in "${cli_tools[@]}"; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        echo "Installing $tool..."
        brew install "$tool"
    else
        echo "$tool already installed"
    fi
done

# Install GUI applications
echo "Installing GUI applications..."
cask_apps=(ghostty nikitabobko/tap/aerospace homerow mouseless)
for app in "${cask_apps[@]}"; do
    app_name=$(basename "$app")
    if ! brew list --cask "$app_name" >/dev/null 2>&1; then
        echo "Installing $app..."
        brew install --cask "$app"
    else
        echo "$app_name already installed"
    fi
done

# Install Oh My Zsh if not present
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Powerlevel10k theme
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
    echo "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Install zsh plugins
if [[ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]]; then
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
    echo "zsh-autosuggestions already installed"
fi

if [[ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
    echo "zsh-syntax-highlighting already installed"
fi

# Install NVM
if [[ ! -d "$HOME/.nvm" ]]; then
    echo "Installing NVM..."
    NVM_VERSION=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
    curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash
fi

# Create config directory
mkdir -p ~/.config/zsh

# Install Tmux Plugin Manager
if [[ ! -d "$HOME/.config/tmux/plugins/tpm" ]]; then
    echo "Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
fi

# Use stow to link dotfiles
echo "Linking dotfiles with stow..."
stow .

echo "Installation complete! Restart your terminal or run 'source ~/.zshrc'"
echo "For tmux: Press prefix + I to install tmux plugins"
