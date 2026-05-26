eval "$(starship init zsh)"

alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias dtem='cd $(mktemp -d)'

# fnm
FNM_PATH="/home/damet/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --shell zsh)"
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
. "$HOME/.cargo/env"

export MOZ_ENABLE_WAYLAND=1

# opencode
export PATH=/home/damet/.opencode/bin:$PATH


# Ctrl + Arrow word movement
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[OC' forward-word
bindkey '^[OD' backward-word
