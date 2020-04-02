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
