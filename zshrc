
export EDITOR=nvim
bindkey -e # disable vim mode in terminal

# no control d
set -o ignoreeof

# fix home/end/delete in tmux
bindkey "\e[H"  beginning-of-line
bindkey "\e[F"  end-of-line
bindkey  "^[[3~"  delete-char
bindkey "\e[3~" delete-char


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
#zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
#zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 
# partial completion suggestions
# zstyle ':completion:*' list-suffixes zstyle ':completion:*' expand prefix suffix 

# option-arrow movement. inclusion makes them included in the "word"
export WORDCHARS="" #"*?_-.[]~=/&;!#$%^(){}<>"


export PATH=~/.local/bin/:$PATH
export PATH=~/.git/commands/:$PATH


# history search with CTRL-R. Paste path with CTRL-T. cd with ALT-C (not in iterm)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# ignore specfic folders
export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore_global -p ~/.fzfignore -g ""'


# prompt
eval "$(starship init zsh)"


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This lo

eval "$(rbenv init - $(basename $SHELL))"

