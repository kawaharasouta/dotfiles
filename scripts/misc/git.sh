#!/bin/bash


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
local path
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

