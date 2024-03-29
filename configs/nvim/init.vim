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

" Define denite mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
	nnoremap <silent><buffer><expr> <CR>
	\ denite#do_map('do_action')
	nnoremap <silent><buffer><expr> d
	\ denite#do_map('do_action', 'delete')
	nnoremap <silent><buffer><expr> p
	\ denite#do_map('do_action', 'preview')
	nnoremap <silent><buffer><expr> q
	\ denite#do_map('quit')
	nnoremap <silent><buffer><expr> i
	\ denite#do_map('open_filter_buffer')
	nnoremap <silent><buffer><expr> <Space>
	\ denite#do_map('toggle_select').'j'
	" let s:exclude_filetypes = 0
endfunction

" Define denite-filter mappings
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  " Open the directory on top
  inoremap <silent><buffer><expr> <C-k> denite#do_map('move_up_path')
  " imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
  " Close denite(not denite-filter so, denite pane will be closed.)
  inoremap <silent><buffer><expr> <C-c> denite#do_map('quit')
  nnoremap <silent><buffer><expr> <C-c> denite#do_map('quit')
  " imap <silent><buffer><expr> <C-c> <Plug>(denite_filter_quit)
  " nmap <silent><buffer><expr> <C-c> <Plug>(denite_filter_quit)
endfunction

let mapleader = "\<Space>"
""" denite hook
nnoremap <silent> <leader>f :Denite file/rec<CR>
nnoremap <silent> <leader>b :Denite buffer<CR>
nnoremap <silent> <leader>g :Denite grep<CR>
nnoremap <silent> <leader>l :Denite line<CR>

" Change file/rec command ag.
call denite#custom#var('file/rec', 'command',
	\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
" Ag command on grep source
call denite#custom#var('grep', {
	\ 'command': ['ag'],
	\ 'default_opts': ['-i', '--vimgrep'],
	\ 'recursive_opts': [],
	\ 'pattern_opt': [],
	\ 'separator': ['--'],
	\ 'final_opts': [],
	\ })

" Change default action.
" When a new file is opened, it is split.
" call denite#custom#kind('file', 'default_action', 'split')

""" std config
syntax on
set nu
set title
set virtualedit=onemore
set hlsearch
hi Comment ctermfg=Blue
set hidden

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

" cursorl
"set ruler
set cursorline

" commnad completion
set wildmenu

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
"nnoremap <silent> O :<C-u>call append(expand('.'), '')<Cr>j

" tab move
" nnoremap <Tab>l gt
" nnoremap <Tab>h gT
" allow moveing tab without save.
""" lua.init example: vim.o.hidden = true
""" Add it in dein.toml hook.
""" set hidden

" when in terminal mode, enable esc
tnoremap <silent> <ESC> <C-\><C-n>

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

" " Launches a terminal at the bottom of the screen at startup
" if has('vim_starting')
" 	split
" 	wincmd j
" 	resize 12
" 	terminal
" 	" The lower setting doesn't work, so I have to "set nonu" manually.
" 	set nonu
" 	wincmd k
" endif

" disable set nu when in terminal emu
augroup FolowTerm
    au!
    au TermOpen * setlocal nonumber
augroup END

"close help window 'q'
autocmd FileType help nnoremap <buffer> q <C-w>c
