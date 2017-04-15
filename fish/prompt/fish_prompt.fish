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
set -g color_yellow (set_color yellow)
set -g color_cyan (set_color cyan)
set -g color_gray (set_color 545454)
set -g color_normal (set_color normal)

set -g color_bold_red (set_color -o red)
set -g color_bold_green (set_color -o green)
set -g color_bold_magenta (set_color -o magenta)

# magic numbers
#set LOCAL_ESCAPES 90

# Helper functions
function __parse_git_branch -d "Parse current Git branch name"
  command git symbolic-ref --short HEAD ^/dev/null;
    or command git show-ref --head -s --abbrev | head -n1 ^/dev/null
end

function __prompt_time
  echo -e (date +"%H$color_yellow:$color_normal%M")
end

function __prompt_git
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
  echo -e "$color_gray$git_branch_name$git_dirty$color_normal$color_cyan$git_arrow_space$git_arrows$color_normal "
end

function __prompt_mode
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

  echo -e "[$mode$color_normal]"
end


function __prompt_folder
  set -l len (printf "%s" "$argv" | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | wc -m)
  set -l maxlen (echo $COLUMNS - $len | bc) 

  set -l current_folder (~/.config/fish/prompt/short_pwd $maxlen)
  
  echo -e $color_cyan$current_folder$color_normal
end

function fish_prompt
  set -l exit_code $status

  # Exit with code 1 if git is not available
  if not which git >/dev/null
    return 1
  end

  # Set default color symbol to green meaning it's all good!
  #set -l color_symbol $color_green

  if test $exit_code -ne 0
    # Symbol color is red when previous command fails
    set color_symbol $color_bold_red
  end

  set -l prompt_time   (__prompt_time)
  set -l prompt_git    (__prompt_git)
  set -l prompt_cwd    (__prompt_folder "$prompt_time $prompt_git")
  set -l prompt_mode   (__prompt_mode)
  set -l prompt_symbol "$color_symbol$symbol_prompt$color_normal"

  set -l prompt "\n"
  set -l prompt "$prompt$prompt_time $prompt_cwd $prompt_git\n"
  set -l prompt "$prompt$prompt_mode $prompt_symbol "

  echo -e -s $prompt
end
