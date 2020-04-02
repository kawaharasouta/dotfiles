""" std config
syntax on
set nu
set title
set virtualedit=onemore
set hlsearch
hi Comment ctermfg=Blue

" tab
set tabstop=2
set shiftwidth=2
set softtabstop=2
"set expandtab
set autoindent
set smartindent

" Case-insensitive when searching
set ignorecase
" Use capital letters to distinguish
set smartcase

" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" shift-o de sitani gyouwo ireruyo
nnoremap O :<C-u>call append(expand('.'), '')<Cr>j

" tab move
nnoremap <Tab>l gt
nnoremap <Tab>h gT

" Remember cursor position
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END
