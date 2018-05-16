# .bashrc


# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# ignore CTRL-D
set -o ignoreeof

# ignore case 
bind 'set completion-ignore-case on'

__set_path() {
  if [ -d $1 ]; then
    PATH="$1:$PATH"
  fi
}

__source_sh() {
  if [ -f $1 ]; then
		. $1
  fi
}

__set_alias() {
  if type "$2" >/dev/null 2> /dev/null; then
    cmd="${@:2}"
    alias $1="$cmd"
  fi
}

__source_sh /etc/bashrc

# User specific aliases and functions
EDITOR=vim

if test -f ~/.dircolors; then 
  eval "$(dircolors -b ~/.dircolors)"
fi

__set_path $HOME/.local/bin/
#__set_path $HOME/.stack/bin/
#__set_path $HOME/.stack/programs/x86_64-linux/ghc-8.0.1/bin/ 
#__set_path $HOME/.cabal/bin/
#__set_path $HOME/.local/share/android-studio/bin/
#__set_path $HOME/.local/share/android-studio/gradle/gradle-2.14.1/bin/
#__set_path /usr/lib64/openmpi/bin/


# history stuff
PROMPT_COMMAND="history -a;"
HISTCONTROL="clear:ls:ignoredups"
shopt -s histappend
#bind '"\eOA": history-substring-search-backward'
#bind '"\e[A": history-substring-search-backward'
#bind '"\eOB": history-substring-search-forward'
#bind '"\e[B": history-substring-search-forward'


alias :q='exit'
alias ls="ls -hFG"
alias la="ls -la"
alias ll="ls -l"

__set_alias "urxvt"   urxvt256c
__set_alias "tmuxl"   tmux list-sessions
__set_alias "tml"     tmux list-sessions
__set_alias "tm"      tmuxa
__set_alias "irc"     weechat
__set_alias "vi"      vim
#__set_alias "vi"      nvim
#__set_alias "vim"     nvim
__set_alias "vi"      vimx
__set_alias "vim"     vimx
__set_alias "open"    xdg-open

__set_alias "battery" upower -i /org/freedesktop/UPower/devices/battery_BAT0
__set_alias "agc"     ag -G '.*\.\(swift\|h\|c\|m\|cpp\|cs\|java\|scala\)$'
__set_alias "kxc"     killall Xcode

#__set_alias "pbcopy"  xsel --clipboard --input
#__set_alias "pbpaste" xsel --clipboard --output

# tmuxa
# vs

__source_sh $HOME/.config/base16-env/base16-env.sh
__source_sh $HOME/.config/base16-env/base16-shell.sh
__source_sh $HOME/.bash_prompt
__source_sh $(brew --prefix)/etc/bash_completion

#__source_sh /usr/share/fzf/shell/key-bindings.bash

unset __set_path
unset __set_alias
unset __source_sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

