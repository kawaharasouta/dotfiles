#!/bin/bash

source ~/git/dotfiles/configs/bash/bash_envs
DOTFILES_HOME=$(pwd)
CONFIGS_PATH=${DOTFILES_HOME}/configs
SCRIPTS_PATH=${DOTFILES_HOME}/scripts
TMP_PATH=${DOTFILES_HOME}/tmp
OS=
GUI_FLAG=0

docker () {
	ln -sf ${CONFIGS_PATH}/bash_profile ~/.bash_profile
	docker_flag=1
	if [ $((docker_flag)) -eq 1 ]; then
		tail_vimrc=`tail -n 1 ~/.vimrc`
		if [ "${tail_vimrc}" = "set ambiwidth=double" ]; then
			docker_flag=0
		fi
	fi
}

# setup () {
# 	# place dotfiles
# 	ln -sf ${CONFIGS_PATH}/tmux.conf ~/.tmux.conf
# 	ln -sf ${CONFIGS_PATH}/tmux/ ~/.tmux
# 	ln -sf ${CONFIGS_PATH}/bashrc ~/.bashrc
# 	ln -sf ${CONFIGS_PATH}/bash ~/.bash
# 	ln -sf ${CONFIGS_PATH}/vimrc ~/.vimrc
# 	ln -sf ${CONFIGS_PATH}/vim ~/.vim
# 	mkdir -p ~/.config
# 	ln -sf ${CONFIGS_PATH}/nvim ~/.config/nvim

# 	mkdir -p ~/.tmux/log/
	
# 	if [ $((docker_flag)) -eq 1 ]; then
# 		echo "set ambiwidth=double" >> ~/.vimrc
# 	fi
	
# 	source ~/.bashrc
# }

git_setup () {
	. ~/.bash/bash_envs
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
	path=${TMP_PATH}/gitignore
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

	# for GUI setting
	if [ $((docker_flag)) -eq 1 ]; then
		echo "Ubuntu Desktop Setting"
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
	sudo yum update && sudo yum install -y wget tmux htop cgdb the_silver_searcher cmake unzip
	sudo yum groupinstall "Development Tools"						###### build essentials for centos
	sudo yum remove vim

	# neovim setup
	if [ ! -e /usr/local/bin/nvim ]; then
		# sudo yum install neovim    ##### too old version
		# curl -LO https://github.com/neovim/neovim/releases/download/v0.4.4/nvim.appimage
		# chmod u+x nvim.appimage && ./nvim.appimage
		# ./nvim.appimage --appimage-extract
		# ./squashfs-root/usr/bin/nvim
		# konoatohaitimenndokattakarayameruwa
		cd ${TMP_PATH}
		git clone https://github.com/neovim/neovim.git && cd $_
		make CMAKE_BUILD_TYPE=RelWithDebInfo
		sudo make install
		sudo yum -y install python38    ##### with python38-pip 
		pip3 install -U pip3					#### error ??????
		pip3 install --user pynvim
		pip3 install --user neovim
		sudo ls -s /usr/local/bin/nvim /usr/bin/vim     #### nannka centos dato katteni rinnku sarenaino
	fi
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

mkdir -p ${TMP_PATH}
. ~/.bash/bash_envs
if [ -e /.dockerenv ]; then
	source ${SCRIPTS_PATH}/misc/docker.sh
fi
source ${SCRIPTS_PATH}/misc/dots.sh
source ${SCRIPTS_PATH}/misc/git.sh
echo $1 | env | grep DISPLAY > /dev/null
if [ "$?" -eq 0 ]; then     
  echo "has GUI"
	GUI_FLAG=1
fi
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
rm -rf ${TMP_PATH}
