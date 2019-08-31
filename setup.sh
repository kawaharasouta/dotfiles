#!/bin/bash
docker () {
	ln -sf ~/git/dotfiles/configs/bash_profile ~/.bash_profile
	apt install -y git
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
	
	
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
	
	#git config
	git config --global user.name "Kawaharasouta"
	git config --global user.email "kawahara6514@gmail.com"
	git config --global core.editor 'vim -c "set fenc=utf-8"'
}
	
debian () {
	#package
	sudo apt install -y gcc make git silversearcher-ag cgdb libncurses5-dev
	
	#skip wait for network to be configured at startup
	sudo systemctl disable systemd-networkd-wait-online.service
	sudo systemctl mask systemd-networkd-wait-online.service
}


if [ -e /.dockerenv ]; then
	docker
	setup
else 
	setup
	debian
fi
