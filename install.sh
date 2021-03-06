#!/usr/bin/env zsh

# macOS install script

echo "Installing tools..."
brew install tmux
brew install starship
brew install reattach-to-user-namespace
brew install the_silver_searcher
brew install neovim
brew install ctags
brew install fzf


echo "Linking configs..."

scriptdir=${0:a:h}

declare -A configdirs

configdirs[zshrc]="~/.zshrc"
configdirs[starship.toml]="~/.config/starship.toml"
configdirs[tmux.conf]="~/.tmux.conf"
configdirs[vim]="~/.vim"
configdirs[vim]="~/.config/nvim"
configdirs[bin]="~/.local/bin"

for source dest in ${(kv)configdirs}; do
    dest=test/$dest
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


