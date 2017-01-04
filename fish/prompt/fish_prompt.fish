# vim: set ft=sh:

# Pure
# by Rafael Rinaldi
# https://github.com/rafaelrinaldi/pure
# MIT License
#
# Modified by SolitaryCipher

# Symbols

#set -g symbol_prompt "❯"
set -g symbol_prompt "\$"
set -g symbol_git_down_arrow "⇣"
set -g symbol_git_up_arrow "⇡"
set -g symbol_git_dirty "*"
set -g symbol_horizontal_bar "—"

# Colors

set -g color_red (set_color red)
set -g color_green (set_color green)
set -g color_blue (set_color blue)
set -g color_blue "\e[0;34m" #(set_color blue)
set -g color_yellow (set_color yellow)
set -g color_cyan (set_color cyan)
set -g color_gray (set_color 545454)
set -g color_normal (set_color normal)

set -g color_bold_red (set_color -o red)
set -g color_bold_green (set_color -o green)
set -g color_bold_magenta (set_color -o magenta)

# magic numbers
set LOCAL_ESCAPES 90

# Helper functions
function __parse_git_branch -d "Parse current Git branch name"
  command git symbolic-ref --short HEAD ^/dev/null;
    or command git show-ref --head -s --abbrev | head -n1 ^/dev/null
end

function __fish_format_full_time
  set -l prompt_date (date +"%H:%M")
  echo -e "$prompt_date "
end

function prompt_git
  set -l is_git_repository (command git rev-parse --is-inside-work-tree ^/dev/null)

  if test -n "$is_git_repository"
    set git_branch_name (__parse_git_branch)

    # Check if there are files to commit
    set -l is_git_dirty (command git status --porcelain --ignore-submodules ^/dev/null)

    if test -n "$is_git_dirty"
      set git_dirty $symbol_git_dirty
    end

    # Check if there is an upstream configured
    command git rev-parse --abbrev-ref '@{upstream}' >/dev/null ^&1; and set -l has_upstream
    if set -q has_upstream
      set -l git_status (command git rev-list --left-right --count 'HEAD...@{upstream}' | sed "s/[[:blank:]]/ /" ^/dev/null)

      # Resolve Git arrows by treating `git_status` as an array
      set -l git_arrow_left (command echo $git_status | cut -c 1 ^/dev/null)
      set -l git_arrow_right (command echo $git_status | cut -c 3 ^/dev/null)

    # If arrow is not "0", it means it's dirty
      if test $git_arrow_left -ne "0"
        set git_arrows $symbol_git_up_arrow
        set git_arrow_space " "
      end

      if test $git_arrow_right -ne "0"
        set git_arrows $git_arrows$symbol_git_down_arrow
        set git_arrow_space " "
      end
    end

    # Format Git prompt output
  end
  set prompt "$color_gray$git_branch_name$git_dirty$color_normal$color_cyan$git_arrow_space$git_arrows$color_normal "
  echo -e $prompt
end

function prompt_mode
  switch $fish_bind_mode
    case default
      set mode $color_bold_red"n"
    case replace-one
      set mode $color_bold_green"r"
    case insert
      set mode $color_bold_green"i"
    case visual
      set mode $color_bold_magenta"v"
  end

  set prompt "[$mode$color_normal] "
  echo -e $prompt
end

function prompt_folder
  set -l current_folder (echo $PWD | sed "s|$HOME|~|")
  set -l current_folder (echo $argv[1] $current_folder | awk -f $HOME/.config/fish/prompt/pwd.awk)
  set prompt $prompt "$color_cyan$current_folder$color_normal "
  echo -e $prompt
end

function prompt_add_folder
  set -l prompt_r $argv[1] 
  set -l prompt_l $argv[2] 

  set -l len (printf "%s" $prompt_r $prompt_l | wc -m)
  set -l len (echo "$len - $LOCAL_ESCAPES" | bc)
  set -l len (echo $COLUMNS - $len - 5| bc) 

  echo -e $prompt_r(prompt_folder $len)$prompt_l
end

function fish_prompt
  set -l exit_code $status

  # Exit with code 1 if git is not available
  if not which git >/dev/null
    return 1
  end

  # Set default color symbol to green meaning it's all good!
  #set -l color_symbol $color_green
  set -l prompt_time

  # Handle previous failed command
  if test $exit_code -ne 0
    # Symbol color is red when previous command fails
    set color_symbol $color_bold_red

    # Prompt failed command execution duration
  end
  set prompt_time (__fish_format_full_time)

  set -l prompt_symbol "$color_symbol$symbol_prompt$color_normal"

  # top-right of the prompt, then add folder to top-left, then add mode+symbol
  set -l prompt (printf "%s" $prompt_time (prompt_git))
  set prompt (prompt_add_folder "$prompt_time" (prompt_git)) "\n"
  set prompt \n $prompt (prompt_mode) $prompt_symbol " "

  echo -e -s $prompt
end
