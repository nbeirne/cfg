##
### Personal Fish Config ###
##

## Environment
function __set_path
  if test -d $argv
    set -gx PATH $argv $PATH
  end
end

__set_path $HOME/.local/bin/
__set_path $HOME/.stack/bin/
__set_path $HOME/.stack/programs/x86_64-linux/ghc-8.0.1/bin/ 
__set_path $HOME/.local/share/android-studio/bin/
__set_path $HOME/.local/share/android-studio/gradle/gradle-2.14.1/bin/

. ~/.cargo/env

if type -q nvim
    set -gx EDITOR nvim
else if type -q vim
    set -gx EDITOR vim
end

if test -z "$SSH_ENV"
    setenv SSH_ENV $HOME/.ssh/environment
end

if not __ssh_agent_is_started
    __ssh_agent_start
end

## Aliases
function __set_alias 
  if type -q $argv[2]
    alias $argv[1] "$argv[2..-1]"
  end
end

alias :q 'exit'

alias "ls"      "ls -h --color --group-directories-first"
__set_alias "urxvt"   urxvt256c
__set_alias "tmuxl"   tmux list-sessions
__set_alias "tm"      tmuxa
__set_alias "irc"     weechat
__set_alias "vi"      vim
#__set_alias "vi"      nvim
#__set_alias "vim"     nvim
__set_alias "vi"      vimx
__set_alias "vim"     vimx
__set_alias "open"    xdg-open

__set_alias "battery" upower -i '/org/freedesktop/UPower/devices/battery_BAT0'

__set_alias "pbcopy"  xsel --clipboard --input
__set_alias "pbpaste" xsel --clipboard --output


## Colors
if test -d $HOME/.config/base16-env 
  source  $HOME/.config/base16-env/base16-env.fish   # environment
  source  $HOME/.config/base16-env/base16-fish.fish  # fish syntax 
  #if status --is-interactive
  #  #eval sh $HOME/.config/base16-env/base16-shell.sh   # term colors
  #end
else
  #echo "Run $ git clone www.github.com/SolitaryCipher/base16-env.git ~/.config/base16-env"
end

if test -e ~/.dircolors; and type -q dircolors
    eval (dircolors -c ~/.dircolors)
end

## Key Bindings
# handled in functions/fish_user_key_bindings.fish (vi mode enabled there)
#fish_user_keybindings

## Prompt
# handled in prompt/fish_prompt.fish and prompt/fish_right_prompt.fish
# note: link these to functions/

