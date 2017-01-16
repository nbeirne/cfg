# Unarchive stuff
function unarchive
    if [ $argv ]
        if [ -f $argv ]
            switch $argv
                case '*.tar.bz2';   tar xvjf $argv
                case '*.tar.gz';    tar xvzf $argv
                case '*.deb';       ar vx $argv
                case '*.tar.xz';    tar xvfJ $argv
                case '*.bz2';       bunzip2 $argv
                case '*.rar';       unrar x $argv
                case '*.gz';        gunzip $argv
                case '*.tar';       tar xvf $argv
                case '*.tbz2';      tar xvjf $argv
                case '*.tgz';       tar xzf $argv
                case '*.zip';       unzip $argv
                case '*.Z';         uncompress $argv
                case '*.7z';        7z x $argv
                case '*' 
                    printf "\"%s\" cannot be extracted with this command\n" $argv
            end
        else
            echo "\"$argv\" is not a valid file"
        end
    else
        echo "This command expects a paramter"
    end
end

complete -c unarchive -x -a "(
    __fish_complete_suffix .tar.bz2
    __fish_complete_suffix .tar.gz
    __fish_complete_suffix .tar.xz
    __fish_complete_suffix .bz2
    __fish_complete_suffix .rar
    __fish_complete_suffix .gz
    __fish_complete_suffix .tar
    __fish_complete_suffix .tbz2
    __fish_complete_suffix .tgz
    __fish_complete_suffix .zip
    __fish_complete_suffix .z
    __fish_complete_suffix .7z
)"


