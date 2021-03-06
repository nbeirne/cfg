

export PATH=~/.local/bin/:$PATH
export EDITOR=nvim
bindkey -e # disable vim mode in terminal

# various aliases
alias vim="nvim"
alias vi="nvim"
alias tmuxl="tmux list-sessions"
alias tml="tmux list-sessions"
alias tm="tmuxa"

alias :q='exit'
alias ls="ls -h -F -G"
alias la="ls -la"
alias ll="ls -l"


# history fixes
# Avoid duplicates
HISTCONTROL=ignoredups:erasedups
# append to history after each command, and load after each command
setopt SHARE_HISTORY


# tab complete tweaks
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select


# history search with CTRL-R
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# prompt
eval "$(starship init zsh)"

