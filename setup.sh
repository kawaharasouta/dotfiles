#!/bin/bash

cp ./configs/tmux.conf ~/.tmux.conf

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp ./configs/vimrc ~/.vimrc
vim +PluginInstall +qall
