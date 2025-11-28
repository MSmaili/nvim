# Dotfiles

My personal dotfiles for development setup.

As name suggests, this is a personal configuration, maybe you do not like what I am doing, so you should adjust or pick things you like.

<img width="2874" height="1620" alt="Neovim setup screenshot" src="https://github.com/user-attachments/assets/2c110a4b-cfba-4273-885f-c1ecaaf8d396" />

## Quick Setup

Good advise is to read the script before running.

```bash
git clone https://github.com/MSmaili/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Supported Platforms

- **macOS** - Homebrew + GUI apps
- **Ubuntu** - APT packages
- **Fedora** - DNF packages

## What's Included

### Applications

- **Terminal**: Ghostty
- **Window Manager**: Aerospace (macOS)
- **Development**: Neovim, Lazygit, Lazydocker

### Shell Setup

- **Shell**: Zsh with Zinit
- **Theme**: Pure
- **Plugins**: autosuggestions, syntax-highlighting
- **Tools**: fzf, fd, bat, tmux

### Configurations

- `.zshrc` - Shell configuration
- `.config/nvim/` - Neovim setup
- `.config/tmux/` - Tmux configuration
- `.config/*/` - Various app configs

## Manual Steps After Install

1. **Install tmux plugins**

Inside tmux, press:

```text
prefix + I
```

to install/update all plugins.

---

2. **Recommended versions**

For best compatibility with the custom scripts and commands used here, it’s recommended to have at least:

- **tmux** version **3.2a**
- **bash** version **5.x**

---

3. **Custom tmux session script**

You can define your own project/session layout in:

```bash
~/.tmux-session.json
```

Use the following format:

- Each **key** is a session name.
- Each **value** is an array of window paths for that session.

Example:

```json
{
  "nvim": ["~/.config/nvim"],
  "dotfiles": ["~/dotfiles"]
}
```

Then run:

```bash
tmux_init
```

This will automatically create tmux sessions based on the configuration in `~/.tmux-session.json`.

You will have also a simple tmux-session switcher
