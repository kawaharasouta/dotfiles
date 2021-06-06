#!/bin/bash

# place dotfiles
ln -sf ${CONFIGS_PATH}/tmux.conf ~/.tmux.conf
ln -sf ${CONFIGS_PATH}/tmux/ ~/.tmux
ln -sf ${CONFIGS_PATH}/bashrc ~/.bashrc
ln -sf ${CONFIGS_PATH}/bash ~/.bash
ln -sf ${CONFIGS_PATH}/vimrc ~/.vimrc
ln -sf ${CONFIGS_PATH}/vim ~/.vim
mkdir -p ~/.config
ln -sf ${CONFIGS_PATH}/nvim ~/.config/nvim

mkdir -p ~/.tmux/log/

if [ $((docker_flag)) -eq 1 ]; then
	echo "set ambiwidth=double" >> ~/.vimrc
fi

source ~/.bashrc

