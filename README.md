# Config Files

## File Locations
        bin/      -> $HOME/.local/bin/
        fish/     -> $HOME/.config/fish/
        vim/      -> $HOME/.config/nvim/
        dircolors -> $HOME/.dircolors
        tmux.conf -> $HOME/.tmux.conf

## Installation:

For vim/nvim/tmux/fish configs:

    git clone https://github.com/SolitaryCipher/cfg

For window manager configs:

    git clone --recursive https://github.com/SolitaryCipher/cfg

### Vim / NeoVim
1. Make sure that the nvim or vim directory exists with vim-plug
2. Install dependancies for plugins (I forget what they are)
3. Link init.vim to $HOME/.vimrc
4. Run :PlugInstall
5. In nvim: Run `:UpdateRemotePlugins`

### Tmux
1. Customize tpm plugins, yank command, and status line if needed
2. Hit `Ctrl-Space I` to install tpm plugins

### Fish
1. Clone www.github.com/SolitaryCipher/base16-env to `$HOME/.config/base16-env`

### XMonad and WM 
See www.github.com/SolitaryCipher/wm

## Dependencies:

### Vim / Neovim
    xsel (vim - except on OSX)

### Tmux
    tmux 2.0 or higher (some stuff broken on 2.2+)
    xsel 

### Fish
    xsel
    
