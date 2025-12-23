#!/bin/bash

# This line is not considered necessary, but is left just in case.
# (because already executed in setup.sh )
source ~/git/dotfiles/configs/bash/bash_envs
mkdir -p ${XDG_CONFIG_HOME}


##### i3 configs #####
ln -sf ${CONFIGS_PATH}/xdg_config/i3 ${XDG_CONFIG_HOME}/i3
##### i3blocks configs #####
ln -sf ${CONFIGS_PATH}/xdg_config/i3blocks ${XDG_CONFIG_HOME}/i3blocks

##### sway configs #####
ln -sf ${CONFIGS_PATH}/xdg_config/sway ${XDG_CONFIG_HOME}/sway

##### kitty configs #####
ln -sf ${CONFIGS_PATH}/xdg_config/kitty ${XDG_CONFIG_HOME}/kitty
if [ ! -f ${XDG_CONFIG_HOME}/kitty/local.conf ]; then
    cp ${CONFIGS_PATH}/xdg_config/kitty/.local.conf.template ${XDG_CONFIG_HOME}/kitty/local.conf
fi

