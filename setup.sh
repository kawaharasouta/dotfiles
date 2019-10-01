#!/bin/bash
docker () {
	ln -sf ~/git/dotfiles/configs/bash_profile ~/.bash_profile
	apt install -y git
	docker_flag=1
	if [ $docker_flag -eq 1 ]; then
		tail_vimrc=`tail -n 1 ~/.vimrc`
		if [ "${tail_vimrc}" = "set ambiwidth=double" ]; then
			docker_flag=0
		fi
	fi
}

setup () {
	#cp ./configs/tmux.conf ~/.tmux.conf
	#cp -r ./configs/tmux/ ~/.tmux/
	#cp ./configs/bashrc ~/.bashrc
	#cp ./configs/vimrc ~/.vimrc
	ln -sf ~/git/dotfiles/configs/tmux.conf ~/.tmux.conf
	ln -sf ~/git/dotfiles/configs/tmux/ ~/.tmux
	ln -sf ~/git/dotfiles/configs/bashrc ~/.bashrc
	ln -sf ~/git/dotfiles/configs/bash ~/.bash
	ln -sf ~/git/dotfiles/configs/vimrc ~/.vimrc
	
	if [ $docker_flag -eq 1 ]; then
		echo "set ambiwidth=double" >> ~/.vimrc
	fi
	
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
	
	#git config
	git config --global user.name "Kawaharasouta"
	git config --global user.email "kawahara6514@gmail.com"
	git config --global core.editor 'vim -c "set fenc=utf-8"'
}
	
debian () {
	#package
	sudo apt install -y gcc build-essential htop arp-scan silversearcher-ag cgdb libncurses5-dev
	
	#skip wait for network to be configured at startup
	sudo systemctl disable systemd-networkd-wait-online.service
	sudo systemctl mask systemd-networkd-wait-online.service
}

mac () {

}

setup
if [ -e /.dockerenv ]; then
	docker
fi
if [ "$(uname)" == "Darwin" ]; then
	mac
elif [ "$(uname)" == "Linux" ]; then
	# now only debian
	debian
fi
