#!/bin/bash

# HOMEを整える
mkdir -p ~/repos

# 未定義の変数を使うと怒られるようにする
set -u

# dotfilesの取得・配置
if [ ! -e ~/repos/dotfiles ] ; then
    cd ~/repos
    git clone https://github.com/elnikkis/dotfiles.git
    cd ~/repos/dotfiles
    rm ~/.bashrc
    yes n | python makelink.py
fi

# windows-settingsの配置
if [ ! -e ~/repos/windows-settings ] ; then
    cd ~/repos
    git clone https://github.com/elnikkis/windows-settings.git
    cp ~/repos/windows-settings/WSL/start_sshd.sh ~/
fi

# venvでPython環境を作る
if [ ! -e ~/pyvenv ] ; then
    mkdir ~/pyvenv
    python3.7 -m venv ~/pyvenv/default
    # これで、source ~/pyvenv/default/bin/activateでpython=python3.xになる
fi

# deinのインストール
#if [ ! -e ~/.local/share/dein ] ; then
#    cd /tmp
#    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
#    sh ./installer.sh ~/.local/share/dein
#fi

pip3 install --user sphinx sphinx-autobuild doc8

