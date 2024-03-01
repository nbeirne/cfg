
export EDITOR=nvim
bindkey -e # disable vim mode in terminal

# no control d
set -o ignoreeof

# fix home/end/delete in tmux
bindkey "\e[H"  beginning-of-line
bindkey "\e[F"  end-of-line
bindkey  "^[[3~"  delete-char

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
setopt histignorespace

# macos complains about insecure directories
ZSH_DISABLE_COMPFIX="true"

# tab complete tweaks
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'


# option-arrow movement. inclusion makes these included in the  "word"
export WORDCHARS="" #"*?_-.[]~=/&;!#$%^(){}<>" 

export PATH=~/.local/bin/:$PATH
export PATH=~/.git/commands/:$PATH

# history search with CTRL-R. Paste path with CTRL-T. cd with ALT-C (not in iterm)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# ignore specfic folders
export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -p ~/.fzfignore -g ""'

# prompt
eval "$(starship init zsh)"

eval "$(rbenv init - $(basename $SHELL))"

