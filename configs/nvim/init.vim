" dein.vim {{{
"  directory configuration
let s:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
let s:dein_config_dir = s:config_home . '/nvim/dein'
let s:toml_file = s:dein_config_dir . '/toml/dein.toml'
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
"  dein installation
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
"  path
let &runtimepath = s:dein_repo_dir . "," . &runtimepath
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file, {'lazy': 0})
  call dein#end()
  call dein#save_state()
endif
"  install new plugins
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" dein.vim }}}




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

" cursorl
"set ruler
set cursorline


" setting on mac
" 'mac' is not running so use 'unix'
if has('unix')
"let ostype = system("uname")
"if ostype == "Darwin"
	nnoremap あ a
	nnoremap い i
	nnoremap う u
	nnoremap お o
	nnoremap っd dd
	nnoremap っy yy	
endif

" Remember cursor position
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END
