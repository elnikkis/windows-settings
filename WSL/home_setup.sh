#!/bin/bash

# HOMEを整える

# dotfilesの取得・配置
if [ ! -e ~/repos/dotfiles ] ; then
    mkdir -p ~/repos
    cd ~/repos
    git clone https://github.com/elnikkis/dotfiles.git
    cd ~/repos/dotfiles
    rm ~/.bashrc
    yes n | python makelink.py
fi
