#!/usr/bin/env zsh

# macOS install script

echo "Installing tools..."
#brew install tmux
#brew install starship
#brew install reattach-to-user-namespace
#brew install the_silver_searcher
#brew install neovim
#brew install ctags
#brew install fzf


echo "Linking configs..."

scriptdir=${0:a:h}

declare -A configdirs

configdirs[zshrc]="$HOME/.zshrc"
configdirs[starship.toml]="$HOME/.config/starship.toml"
configdirs[tmux.conf]="$HOME/.tmux.conf"
configdirs[vim]="$HOME/.vim"
configdirs[vim]="$HOME/.config/nvim"
configdirs[bin]="$HOME/.local/bin"

for source dest in ${(kv)configdirs}; do
    destdir=$(dirname $dest)
    src=$scriptdir/$source
    if [ ! -d "$destdir" ]
    then
      echo "Creating directory: $destdir"
      mkdir -p $destdir
    fi

    if [ ! -e $dest ]
    then
      echo "Linking: $scriptdir/$source -> $dest"
      ln -s $src $dest
    else
      echo "File already exists: $dest"
    fi
done


