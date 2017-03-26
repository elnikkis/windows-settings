#!/bin/bash

# HOMEを整える

mkdir -p ~/repos

# dotfilesの取得・配置
if [ ! -e ~/repos/dotfiles ] ; then
    cd ~/repos
    git clone https://github.com/elnikkis/dotfiles.git
    cd ~/repos/dotfiles
    rm ~/.bashrc
    yes n | python makelink.py
fi

if [ ! -e ~/repos/windows-settings ] ; then
    cd ~/repos
    git clone https://github.com/elnikkis/windows-settings.git
    cp ~/repos/windows-settings/WSL/start_sshd.sh ~/
fi
