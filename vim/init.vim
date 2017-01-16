
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
  let g:load_path   = "~/.config/nvim/"
endif

exec "so " . g:load_path . "/base.vim"
exec "so " . g:load_path . "/plugin.vim"

if has("nvim")
" == NVIM Specific Settigngs == {{{
  tnoremap <Esc> <C-\><C-n>
" }}}
else
" == Vim Specific System Settings == {{{
  set viminfo+=n~/.local/share/viminfo
  set directory^=$HOME/.vim/tmp//

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
