_ta() {
	local cur prev words cword split
	_init_completion || return
	
	# local defaultIFS=$' \t\n'
	# local IFS=$defaultIFS
	
	local SOCKETS=$(ls $TMUX_TMPDIR/tmux-`id -u`)
	
	COMPREPLY=( $(compgen -W "${SOCKETS}" -- "${cur}") )
	
	# case $cword in
	#     1)
	#         COMPREPLY=( $(compgen -W 'edit remove list' -- "$cur") )
	#         ;;
	#     *)
	#         case ${words[1]} in
	#             edit)
	#                 IFS=$'\n'; COMPREPLY=( $(compgen -W '$(note list)' -- "$cur") ); IFS=$defaultIFS
	#                 ;;
	#             remove)
	#                 IFS=$'\n'; COMPREPLY=( $(compgen -W '$(note list)' -- "$cur") ); IFS=$defaultIFS
	#                 ;;
	#             list)
	#                 ;;
	#         esac
	#         ;;
	# esac
}

complete -F _ta ta
