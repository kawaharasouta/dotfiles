#!/bin/bash


ln -sf ${CONFIGS_PATH}/bash_profile ~/.bash_profile
docker_flag=1
if [ $((docker_flag)) -eq 1 ]; then
	tail_vimrc=`tail -n 1 ~/.vimrc`
	if [ "${tail_vimrc}" = "set ambiwidth=double" ]; then
		docker_flag=0
	fi
fi

