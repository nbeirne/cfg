
function --wraps="tmux attach-session -t" tmuxa 
  if count $argv > /dev/null
    tmux new-session -A -s $argv[1]
  else
    tmux new-session -A
  end
end


