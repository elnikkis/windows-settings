#!/bin/bash

# lxrun /install をしたあとのセットアップスクリプト
#  - hostsの設定
#  - パッケージのインストール
#  - sshの設定
#  - neovimのインストール


# 未定義の変数を使うと怒られるようにする
set -u

# Check run as root
if [ "$(id -u)" != "0" ]; then
    echo "Need superuser"
    echo "Usage: sudo bash $0"
    exit 1
fi


# hostsの設定
echo "Setting /etc/hosts..."
cat /etc/hosts | grep `hostname` > /dev/null || sh -c 'echo 127.0.1.1 $(hostname) >> /etc/hosts'


# apt update
apt-get update


# パッケージのインストール
echo "Installing packages..."
apt-get install -y build-essential git


# sshの設定
echo "Setting sshd..."
service ssh stop

# バックアップがなければコピー
if [ ! -e /etc/ssh/sshd_config.bak ] ; then
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
fi

# UsePrivilegeSeparation no にする
if grep '^UsePrivilegeSeparation yes' /etc/ssh/sshd_config > /dev/null ; then
    echo '"Writing UsePrivilegeSeparation no" in /etc/ssh/sshd_config'
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.tmp
    cat /etc/ssh/sshd_config.tmp | sed -e 's/UsePrivilegeSeparation yes/#UsePrivilegeSeparation yes\nUsePrivilegeSeparation no/' > /etc/ssh/sshd_config
    rm -f /etc/ssh/sshd_config.tmp
fi
# PasswordAuthentication yes にする
if grep '^PasswordAuthentication no$' /etc/ssh/sshd_config ; then
    echo 'Writing "PasswordAuthentication yes" in /etc/ssh/sshd_config'
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.tmp
    cat /etc/ssh/sshd_config.tmp | sed -e 's/PasswordAuthentication no/#PasswordAuthentication no\nPasswordAuthentication yes/' > /etc/ssh/sshd_config
    rm -f /etc/ssh/sshd_config.tmp
fi

# UsePrivilegeSeparation no を設定したあとにこれを実行しないと接続できるようにならない
dpkg-reconfigure openssh-server

service ssh start


# neovimのインストール
apt-get install python-software-properties
add-apt-repository ppa:neovim-ppa/unstable -y
apt-get update
apt-get install -y python-dev python-pip python3-dev python3-pip
apt-get install -y neovim

