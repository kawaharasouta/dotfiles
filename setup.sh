#!/bin/bash

cp ./configs/tmux.conf ~/.tmux.conf
cp -r ./configs/tmux/ ~/.tmux/
cp ./configs/bashrc ~/.bashrc

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp ./configs/vimrc ~/.vimrc
vim +PluginInstall +qall

#git config
git config --global user.name "Kawaharasouta"
git config --global user.email "kawahara6514@gmail.com"
git config --global core.editor 'vim -c "set fenc=utf-8"'

#package
apt install -y gcc make git silversearcher-ag cgdb

#skip wait for network to be configured at startup
sudo systemctl disable systemd-networkd-wait-online.service
sudo systemctl mask systemd-networkd-wait-online.service
