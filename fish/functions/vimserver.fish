function vimserver
  set -l ARGSTART 1
  set -l VIMSERVER $VIMSERVER

  if test -z $VIMSERVER 
    set ARGSTART 2
    set VIMSERVER $argv[1]
  end
 
  set -l FILES
  if test (count $argv) -ge $ARGSTART
    set FILES $argv[$ARGSTART..-1]
  end

  if test -z $VIMSERVER
    echo "Specify a server or VIMSERVER"
  else if test -z "$FILES"
    for server in (vim --serverlist)
      set server (echo $server | tr '[A-Z]' '[a-z]')
      if test $server = $VIMSERVER 
        echo "Server is already running."
        return
      end
    end
    vim --servername $VIMSERVER
  else 
    vim --servername $VIMSERVER --remote $FILES
  end
end
