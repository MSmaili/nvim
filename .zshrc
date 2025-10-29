# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
##
# options
##
# When deleting with <C-w>, delete file names at a time.
WORDCHARS=${WORDCHARS/\/}
export EDITOR=nvim
export TERM=xterm-256color



## ----------------------------------------
# Powerlevel10k Instant Prompt
# ----------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# ----------------------------------------
# Oh-My-Zsh Setup
# ----------------------------------------
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"

ZSH_THEME="powerlevel10k/powerlevel10k"
# Plugins
plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh


# ----------------------------------------
# Powerlevel10k Configuration
# ----------------------------------------
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


# ----------------------------------------
# FZF Configuration
# ----------------------------------------
if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND="fd --type f --color=always"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

export FZF_DEFAULT_OPTS="\
--ansi \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8,\
fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc,\
marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
export FZF_CTRL_R_OPTS="--layout=reverse"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ----------------------------------------
# NVM Setup
# ----------------------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# ----------------------------------------
# Display Settings
# ----------------------------------------
export DISPLAY=localhost:10.0

# ----------------------------------------
# Functions
# ----------------------------------------
function lg {
  if ! command -v lazygit >/dev/null 2>&1; then
    echo "lazygit not installed"
    return 1
  fi
  
  local git_dir
  git_dir=$(git rev-parse --git-dir 2>/dev/null)
  if [[ $? -eq 0 ]]; then
    local lock_file="${git_dir}/index.lock"
    if [[ -f "$lock_file" ]]; then
      echo "Removing stale lock file: $lock_file"
      rm "$lock_file"
    fi
  fi
  command lazygit "$@"
}

# ----------------------------------------
# Aliases
# ----------------------------------------
alias vi="nvim"
command -v lazydocker >/dev/null 2>&1 && alias ld="lazydocker"
alias t="tmux a"
command -v bat >/dev/null 2>&1 && alias cat='bat -pp'
if command -v fzf >/dev/null 2>&1 && command -v bat >/dev/null 2>&1; then
  alias ovi='nvim "$(fzf --preview="bat --style=numbers --color=always {}" --height=40% --reverse)"'
fi

# load modular configs from ~/.config/zsh/
for file in ~/.config/zsh/*.zsh(N); do
  [[ -r "$file" ]] && source "$file"
done


# Custom aliases for git diffing with perview
gdiff() {
  preview="git diff $@ --color=always -- {-1}"
  git diff $@ --name-only | fzf -m --ansi --preview $preview
}
zstyle ':fzf-tab:*' use-fzf-default-opts yes

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
