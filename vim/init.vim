"
"" SolitaryCipher's vim settings
"

" To install:
  " edit pluginpath and the source paths below
  " See plugin.vim for plugin install guide.

set nocompatible " enable vim-only features.

let g:use_plugins = 1

if has("nvim")
  let g:plugin_path = "~/.config/nvim/plugged/"
  let g:load_path   = "~/.config/nvim/"
else
  let g:plugin_path = "~/.vim/plugged/"
  let g:load_path   = "~/.vim/"
endif


"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if has('nvim') || has('termguicolors')
  set termguicolors
endif

" truecolor support + tmux
"set t_8b=[48;2;%lu;%lu;%lum
"set t_8f=[38;2;%lu;%lu;%lum

exec "so " . g:load_path . "/base.vim"
exec "so " . g:load_path . "/gvim.vim"
"exec "so " . g:load_path . "/plugin.vim"

if has("nvim")
  set mouse=a
  exec "so " . g:load_path . "/plugin.lua"
" == NVIM Specific Settigngs == {{{
  "tnoremap <Esc> <C-\><C-n>
" }}}
else
" == Vim Specific System Settings == {{{
  set viminfo+=n~/.local/share/viminfo
  set directory^=$HOME/.vim/tmp/

  set mouse=a
  set ttymouse=xterm2
  " map <ScrollWheelUp> <C-Y>
  " map <ScrollWheelDown> <C-E>

  if executable("xsel") 
    imap <C-v> <ESC>:r !xsel -b<CR>A
    vmap <C-v> c<ESC>:r !xsel -b<CR>
    vmap <C-c> :w !xsel -i -b<CR><CR>
    vmap <C-x> "+c
  end

  if has("macunix")
    imap <C-v> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
    vmap <C-v> c<ESC>:r !pbpaste<CR>
    vmap <C-c> :w !pbcopy<CR><CR> 
    vmap <C-x> :!pbcopy<CR>  
  end
" }}}
endif

set modelines=1
" vim:foldmethod=marker:foldlevel=0
