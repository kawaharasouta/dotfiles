#!/bin/bash

# This line is not considered necessary, but is left just in case.
# (because already executed in setup.sh )
source ~/git/dotfiles/configs/bash/bash_envs

# mkdir needed directory
mkdir -p ~/.config
mkdir -p ~/.tmux/log/

# place any dotfiles
### tmux dotfiles
ln -sf ${CONFIGS_PATH}/tmux.conf ~/.tmux.conf
ln -sf ${CONFIGS_PATH}/tmux/ ~/.tmux
### bash dotfiles
ln -sf ${CONFIGS_PATH}/bashrc ~/.bashrc
ln -sf ${CONFIGS_PATH}/bash ~/.bash
#ln -sf ~/.bash/bash_completion ${XDG_CONFIG_HOME}/bash_completion
### vim dotfiles
ln -sf ${CONFIGS_PATH}/vimrc ~/.vimrc
ln -sf ${CONFIGS_PATH}/vim ~/.vim
### neovim configs
ln -sf ${CONFIGS_PATH}/nvim ~/.config/nvim


if [ $((docker_flag)) -eq 1 ]; then
	echo "set ambiwidth=double" >> ~/.vimrc
fi

source ~/.bashrc

