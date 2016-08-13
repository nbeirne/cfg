##
### Personal Fish Config ###
##

## Environment
if test -d $HOME/.local/bin
  set -gx PATH $HOME/.local/bin/ $PATH
end

# Vim 
if type -q nvim
    set -gx EDITOR nvim
    #alias vim 'nvim'
    #alias vi 'nvim'
else if type -q vim
    set -gx EDITOR vim
    #alias vi 'vim'
else
    echo "Missing nvim and vim"
end

## Aliases
alias tmuxl 'tmux list-session'
alias irc 'weechat'

if type -q xdg-open
  alias open "xdg-open"
end

if type -q upower
  alias battery "upower -i '/org/freedesktop/UPower/devices/battery_BAT0'"
end

if not type -q pbcopy 
    alias pbcopy "xsel --clipboard --input"
    alias pbpaste "xsel --clipboard --output"
end

## Colors
if test -d $HOME/.config/base16-env 
  source  $HOME/.config/base16-env/base16-env.fish   # environment
  eval sh $HOME/.config/base16-env/base16-shell.sh   # term colors
  source  $HOME/.config/base16-env/base16-fish.fish  # fish syntax 
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

