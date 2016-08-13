# Set title to current folder and shell name

function __parse_current_folder -d "Replace '$HOME' with '~'"
  pwd | sed "s|$HOME|~|"
end

function fish_title
  set -l basename (command basename $PWD)
  set -l current_folder (__parse_current_folder)
  set -l command $argv[1]
  #set -l prompt "$basename: $command $symbol_horizontal_bar $_"
  set -l prompt "$_"


  if test "$command" -eq ""
    set prompt "$current_folder"
  end

  echo $prompt
end
