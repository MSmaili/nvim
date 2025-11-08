[[ -n "$__ZSHRC_LOADED" ]] && return
__ZSHRC_LOADED=1

# ------------------------------------------------------------
# Modular Configs
# ------------------------------------------------------------
for file in ~/.config/zsh/*.zsh(N); do
    [[ -r "$file" ]] && source "$file"
done

# ------------------------------------------------------------
# Zsh Options & Environment Variables
# ------------------------------------------------------------
setopt autocd              # Type directory name to cd
setopt correct             # Auto-correct minor typos
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTTIMEFORMAT="%F %T "
setopt sharehistory        # share across sessions
setopt appendhistory       # append instead of overwrite
setopt hist_ignore_space   # ignore commands starting with space
setopt hist_ignore_dups    # ignore all duplicates
setopt hist_find_no_dups   # ignore duplicates during search
HISTDUP=erase              # optional, reinforce duplicate removal

# When deleting with <C-w>, delete file names at a time
WORDCHARS=${WORDCHARS/\/}

# Basic environment
export EDITOR=nvim
export TERM=xterm-256color
[[ -z "$DISPLAY" ]] && export DISPLAY=localhost:10.0

# PATH management
typeset -U path  # Keep unique entries
path=(
    "$HOME/.local/bin"
    "$HOME/bin"
    "/usr/local/bin"
    $path
)
export XDG_CONFIG_HOME="$HOME/.config"

# ------------------------------------------------------------
# Zinit
# ------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# --- Plugins ---
zinit light agkozak/zsh-z                # Fast directory jump
zinit light zsh-users/zsh-completions    # Completions
zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure            # Prompt
zinit light Aloxaf/fzf-tab               # FZF tab completion
zinit ice wait lucid atinit'zpcompinit; zpcdreplay'
zinit light zsh-users/zsh-syntax-highlighting

autoload -Uz compinit && compinit -C     # Caches completions
zinit cdreplay -q

# Completion styles (before compinit)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # Case-insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"  # Colored completion
zstyle ':completion:*' menu select  # Interactive menu
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zsh/cache"

# fzf-tab configuration
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath 2>/dev/null || ls -1 $realpath'
zstyle ':fzf-tab:*' fzf-flags --height=60%

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# ------------------------------------------------------------
# mise
# ------------------------------------------------------------
if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi

# ------------------------------------------------------------
# FZF Configuration
# ------------------------------------------------------------
if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
else
    export FZF_DEFAULT_COMMAND='find . -type f 2>/dev/null'
fi
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_DEFAULT_OPTS='
--height=30%
--border
--layout=reverse
--bind "ctrl-d:preview-down"
--bind "ctrl-u:preview-up"
--bind "ctrl-f:preview-page-down"
--bind "ctrl-b:preview-page-up"
--bind "ctrl-y:accept"
--bind "alt-p:toggle-preview"
--ansi
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8,\
fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc,\
marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8\
'

export FZF_CTRL_R_OPTS="--layout=reverse"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always {} 2>/dev/null || cat {}'"

if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
fi


# ------------------------------------------------------------
# Aliases
# ------------------------------------------------------------
alias vi="nvim"
alias vim="nvim"
alias grep='grep --color=auto'
alias t="tmux attach || tmux"

# ls/eza aliases
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -lh --icons --group-directories-first'
    alias la='eza -lah --icons --group-directories-first'
    alias tree='eza --tree --icons'
else
    alias ls='ls --color'
    alias ll='ls -lh'
    alias la='ls -lah'
fi

# Git aliases
alias gs='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --decorate --all'
alias gpro='git pull --rebase origin'

# Docker aliases
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcl='docker compose logs -f'

# Kubernetes aliases
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgd='kubectl get deployments'
alias kl='kubectl logs -f'

# Hash directories for quick movement
hash -d dotfiles="$HOME/dotfiles"
hash -d nvim="$HOME/.config/nvim"

# Conditional aliases
command -v lazydocker >/dev/null 2>&1 && alias ld="lazydocker"
command -v bat >/dev/null 2>&1 && alias cat='bat -pp'

if command -v fzf >/dev/null 2>&1 && command -v bat >/dev/null 2>&1; then
    alias ovi='nvim "$(fzf --preview="bat --style=numbers --color=always {}" --height=40% --reverse)"'
fi


# ------------------------------------------------------------
# Functions
# ------------------------------------------------------------
# LazyGit with lock file handling
lg() {
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

# Git diff with fzf preview
gdiff() {
    local preview_cmd
    if command -v delta >/dev/null 2>&1; then
        preview_cmd="git diff $@ --color=always -- {-1} | delta --side-by-side --width \${FZF_PREVIEW_COLUMNS:-100}"
    else
        preview_cmd="git diff $@ --color=always -- {-1}"
    fi
    git diff $@ --name-only | fzf -m --ansi --preview "$preview_cmd" \
        --layout=reverse --height=100% --preview-window=down:90%
}

# CD to git root
cdg() {
    local root=$(git rev-parse --show-toplevel 2>/dev/null)
    if [[ -n "$root" ]]; then
        cd "$root"
    else
        echo "Not in a git repository"
    fi
}

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract various archive formats
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz)  tar xzf "$1" ;;
            *.tar.xz)  tar xJf "$1" ;;
            *.bz2)     bunzip2 "$1" ;;
            *.gz)      gunzip "$1" ;;
            *.tar)     tar xf "$1" ;;
            *.tbz2)    tar xjf "$1" ;;
            *.tgz)     tar xzf "$1" ;;
            *.zip)     unzip "$1" ;;
            *.Z)       uncompress "$1" ;;
            *.7z)      7z x "$1" ;;
            *.rar)     unrar x "$1" ;;
            *)         echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Fuzzy find and kill process
fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m --height=40% --layout=reverse --header='Select process to kill' --preview 'echo {}' --preview-window=down:3:wrap | awk '{print $2}')
    if [ -n "$pid" ]; then
        echo "$pid" | xargs kill -"${1:-9}"
        echo "Killed process(es): $pid"
    fi
}

# Quick project navigation (adjust path to your projects directory)
export PROJECTS="$HOME/projects"
alias p='cd $PROJECTS'
