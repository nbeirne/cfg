# Removes right prompt


set -g color_yellow (set_color yellow)
set -g color_dark_gray (set_color 93A1A1)
set -g color_gray (set_color 93A1A1)
set -g color_normal (set_color normal)

function fish_right_prompt
#  set -l prompt_date (date +"$color_gray%H$color_yellow:$color_dark_gray%m$color_normal")
#  echo -e $prompt_date "\n\n"
end
