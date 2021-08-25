

export PATH=~/.local/bin/:$PATH
export EDITOR=nvim
bindkey -e # disable vim mode in terminal

# no control d
set -o ignoreeof

# fix home/end
bindkey "\e[H"  beginning-of-line
bindkey "\e[F"  end-of-line

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

# macos complains about insecure directories
ZSH_DISABLE_COMPFIX="true"

# tab complete tweaks
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'


# history search with CTRL-R. Paste path with CTRL-T. cd with ALT-C (not in iterm)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# prompt
eval "$(starship init zsh)"

