set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'fatih/vim-go'
Plugin 'markonm/traces.vim'
Plugin 'reireias/vim-cheatsheet'

call vundle#end()
filetype plugin indent on



" NERDTree key
nnoremap <silent><C-e> :NERDTreeToggle<CR>
" default NERDTree activate(damesou?)
let g:nerdtree_tabs_open_on_console_startup=1
" show secret file
let NERDTreeShowHidden = 1
" tab move
nnoremap <Tab>l gt
nnoremap <Tab>h gT
" ikkinitojiruyatu
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Cheetsheet
let g:cheatsheet#cheat_file = '~/.vim/cheatsheet.md'
nnoremap <C-h> :Cheat<CR>



