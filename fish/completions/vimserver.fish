function __vim_server_list
  if test -z  $VIMSERVER
    return 0
  else
    return 1
  end
end

complete -c vimserver -x -a '(vimx --serverlist)' -d 'vim server list' -n '__vim_server_list'

