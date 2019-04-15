#!/bin/bash

cp ./configs/tmux.conf ~/.tmux.conf

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp ./configs/vimrc ~/.vimrc
vim +PluginInstall +qall

#git config
git config --global user.name "Kawaharasouta"
git config --global user.email "kawahara6514@gmail.com"
git config --global core.editor 'vim -c "set fenc=utf-8"'
