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


# Update packages
apt update

# Generate locale (Begins intractive session)
# ja_JP.UTF-8を探して有効にする
dpkg-reconfigure locales


# パッケージのインストール
echo "Installing packages..."
apt install -y man build-essential git llvm tmux rsync curl clang python-dev python-pip python3-dev python3-pip ssh vim-nox
# Pythonをコンパイルするときの依存ライブラリなど
#apt install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libncurses5-dev libgdbm-dev liblzma-dev

# Python 3のbuild dependencyのインストール
if grep 'deb-src http://deb.debian.org/debian stretch main' /etc/apt/sources.list > /dev/null ; then
    echo 'deb-src http://deb.debian.org/debian stretch main' >> /etc/apt/sources.list
    echo 'Added deb-src line to /etc/apt/sources.list'
fi
apt build-dep python3

#TODO /usr/local/src 以下を使うことを検討
# ref: https://www.python.org/downloads/release/python-361/
cd /tmp
wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tar.xz
tar Jxvf Python-3.7.3.tar.xz
cd Python-3.7.3
# altinstall: pythonx.xの実行コマンドだけインストールする
#./configure --enable-optimizations && make && make altinstall
./configure && make -j2 && make altinstall

# デフォルトエディタの設定
# /usr/bin/vim.nox を選ぶ
update-alternatives --config editor

# Homeのセットアップスクリプトを呼び出す
cd /tmp
curl https://raw.githubusercontent.com/elnikkis/windows-settings/master/WSL/home_setup.sh > home_setup.sh
sudo -u nicky bash home_setup.sh

