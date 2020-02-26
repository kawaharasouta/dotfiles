#!/bin/bash
docker () {
	ln -sf ~/git/dotfiles/configs/bash_profile ~/.bash_profile
	apt install -y git
	docker_flag=1
	if [ $((docker_flag)) -eq 1 ]; then
		tail_vimrc=`tail -n 1 ~/.vimrc`
		if [ "${tail_vimrc}" = "set ambiwidth=double" ]; then
			docker_flag=0
		fi
	fi
}

setup () {
	ln -sf ~/git/dotfiles/configs/tmux.conf ~/.tmux.conf
	ln -sf ~/git/dotfiles/configs/tmux/ ~/.tmux
	ln -sf ~/git/dotfiles/configs/bashrc ~/.bashrc
	ln -sf ~/git/dotfiles/configs/bash ~/.bash
	ln -sf ~/git/dotfiles/configs/vimrc ~/.vimrc
	
	if [ $((docker_flag)) -eq 1 ]; then
		echo "set ambiwidth=double" >> ~/.vimrc
	fi
	
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
	
	#git config
	git config --global user.name "Kawaharasouta"
	git config --global user.email "kawahara6514@gmail.com"
	git config --global core.editor 'vim -c "set fenc=utf-8"'
}
	
ubuntu () {
	echo "ubuntu"

	#package
	sudo apt update && sudo apt install -y build-essential htop arp-scan silversearcher-ag cgdb libncurses5-dev vim tmux
	
	#skip wait for network to be configured at startup
	sudo systemctl disable systemd-networkd-wait-online.service
	sudo systemctl mask systemd-networkd-wait-online.service
}

mac () {
	echo "MAC"

	if [ ! -e /usr/local/bin/brew ]; then
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi
	brew install wget htop tmux arp-scan ag coreutils
}

centos () {
	echo "centos"
	
	sudo yum update && sudo yum install -y epel-release 
	sudo yum update && sudo yum install -y vim wget tmux htop cgdb the_silver_searcher
}

setup
if [ -e /.dockerenv ]; then
	docker
fi
case "$(uname)" in
	Darwin*)	mac ;;
	Linux*)		
		if [[ -f /etc/os-release ]]; then
			. /etc/os-release
			case $ID in 
				ubuntu ) ubuntu ;;
				centos ) centos ;;
				*			 ) echo "cannot find linux destribution." ;;
			esac
		fi
		;;
	*)				echo "unknown OS"
esac
setup
