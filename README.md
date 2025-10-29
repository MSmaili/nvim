# Dotfiles

My personal dotfiles for development setup.

<img width="2874" height="1620" alt="Neovim setup screenshot" src="https://github.com/user-attachments/assets/2c110a4b-cfba-4273-885f-c1ecaaf8d396" />

## Quick Setup

```bash
# git clone TODO: ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Supported Platforms

- **macOS** - Homebrew + GUI apps
- **Ubuntu** - APT packages
- **Fedora** - DNF packages
- **Arch Linux** - Pacman packages

## What's Included

### Applications

- **Terminal**: Ghostty
- **Window Manager**: Aerospace (macOS) TODO: gnome setup and hyperland on omarchy
- **Development**: Neovim, Lazygit, Lazydocker

### Shell Setup

- **Shell**: Zsh with Oh My Zsh
- **Theme**: Powerlevel10k
- **Plugins**: autosuggestions, syntax-highlighting
- **Tools**: fzf, fd, bat, tmux

### Configurations

- `.zshrc` - Shell configuration
- `.p10k.zsh` - Powerlevel10k theme
- `.config/nvim/` - Neovim setup
- `.config/tmux/` - Tmux configuration
- `.config/*/` - Various app configs

## Manual Steps After Install

1. **Tmux plugins**: Press `prefix + I` in tmux
2. **Powerlevel10k**: Run `p10k configure` to customize

## Updating

```bash
cd ~/dotfiles
git pull
# macOS
brew bundle --no-lock
# Linux
sudo apt update && sudo apt upgrade  # Ubuntu
sudo dnf upgrade                     # Fedora
sudo pacman -Syu                     # Arch
```
