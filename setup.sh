#!/bin/bash

DOTFILES_HOME=$(pwd)
OS=

docker () {
	ln -sf ~/git/dotfiles/configs/bash_profile ~/.bash_profile
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
	ln -sf ~/git/dotfiles/configs/vim ~/.vim
	mkdir -p ~/.config
	ln -sf ~/git/dotfiles/configs/nvim ~/.config/nvim
	
	if [ $((docker_flag)) -eq 1 ]; then
		echo "set ambiwidth=double" >> ~/.vimrc
	fi
	
	source ~/.bashrc
}

git_setup () {
	local path
	# git basic config
	git config --global user.name "Kawaharasouta"
	git config --global user.email "kawahara6514@gmail.com"
	git config --global core.editor 'vim -c "set fenc=utf-8"'

	# gitignore global setting
	### FreeBSD ha taiou sitenai
	if [ -z ${OS} ] ; then
		echo "FreeBSD gitignore_Global setting is not supported."
		return
	fi
	path=${DOTFILES_HOME}/tmp/gitignore
	mkdir -p ${path} && cd $_
	git init 
	git config core.sparsecheckout true
	git remote add origin https://github.com/github/gitignore.git
	echo Global > .git/info/sparse-checkout
	git pull origin master
	mkdir -p ${XDG_CONFIG_HOME}/git
	cat ${path}/Global/${OS}.gitignore ${path}/Global/Vim.gitignore >> ${XDG_CONFIG_HOME}/git/ignore
	cd ${DOTFILES_HOME}
}

build-vim () {
	mkdir ~/tmp/ && git clone https://github.com/vim/vim.git ~/tmp/vim -b v8.2.0000 
	cd ~/tmp/vim
	./configure --with-features=huge --enable-fail-if-missing
	make && sudo make install

	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
}
	
ubuntu () {
	echo "ubuntu"

	#package
	sudo apt update && sudo apt install -y build-essential htop arp-scan silversearcher-ag cgdb libncurses5-dev tmux
	sudo apt remove vim
	
	#skip wait for network to be configured at startup
	sudo systemctl disable systemd-networkd-wait-online.service
	sudo systemctl mask systemd-networkd-wait-online.service

	# neovim setup
	if [ ! -e /usr/bin/nvim ]; then
		sudo apt install -y software-properties-common
		sudo add-apt-repository -y ppa:neovim-ppa/stable
		sudo apt update 
		sudo apt install -y neovim
		sudo apt install -y python3-dev python3-pip
		pip3 install -U pip3
		pip3 install neovim
		sudo apt install -y xclip xsel
	fi
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
	sudo yum update && sudo yum install -y wget tmux htop cgdb the_silver_searcher
	sudo yum groupinstall "Development Tools"						###### build essentials for centos
	sudo yum remove vim

	# neovim setup
	sudo yum install neovim
	sudo yum install python38    ##### with python38-pip 
	pip3 install -U pip3					#### error ??????
	pip3 install --user pynvim
	pip3 install --user neovim
	sudo ls -s /usr/bin/nvim /usr/bin/vim     #### nannka centos dato katteni rinnku sarenaino
}

freebsd () {
	echo "FreeBSD"
	sudo pkg install -y bash tmux gcc cgdb the_silver_searcher ncurses
	chsh -s bash khwarizmi
	build-vim
	#sudo echo "proc	/proc	procfs	rw	0	0" >> /etc/fstab
	echo "you need to add \"proc	/proc	procfs	rw	0	0\" to /etc/fstab"
	echo "and reboot."
}

mkdir -p ${DOTFILES_HOME}/tmp
. ~/.bash/bash_envs
if [ -e /.dockerenv ]; then
	docker
fi
setup
case "$(uname)" in
	Darwin*)	
		OS=macOS
		mac ;;
	Linux*)
		OS=Linux
		if [[ -f /etc/os-release ]]; then
			. /etc/os-release
			case $ID in 
				ubuntu ) ubuntu ;;
				centos ) centos ;;
				*			 ) echo "cannot find linux destribution." ;;
			esac
		fi
		;;
	FreeBSD*)
		freebsd ;;
	*)				echo "unknown OS"
esac
git_setup
rm -rf ${DOTFILES_HOME}/tmp
