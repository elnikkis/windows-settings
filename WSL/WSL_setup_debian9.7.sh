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


# パッケージのインストール
echo "Installing packages..."
apt install -y build-essential git llvm tmux rsync curl clang python-dev python-pip python3-dev python3-pip ssh vim-nox
# Pythonをコンパイルするときの依存ライブラリなど
apt install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libncurses5-dev libgdbm-dev liblzma-dev


# Homeのセットアップスクリプトを呼び出す
cd /tmp
curl https://raw.githubusercontent.com/elnikkis/windows-settings/master/WSL/home_setup.sh > home_setup.sh
sudo -u nicky bash home_setup.sh

