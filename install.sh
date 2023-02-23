#!/bin/sh

# exit unless we're running as root
if [ `id -u` -ne 0 ]; then
    echo "You must be root to run this script."
    exit 1
fi

# exit unless on REMOTE_CONTAINERS
if [ -z "$REMOTE_CONTAINERS" ]; then
    echo "You must be on a REMOTE_CONTAINERS to run this script."
    exit 1
fi


# exit unless distro is Debian
if [ -z "`which apt-get`" ]; then
    echo "You must be on a Debian-based distro to run this script."
    exit 1
fi

apt-get update
apt-get install -y tig locales

chsh -s /bin/zsh

cp ~/dotfiles/zshrc ~/.zshrc
cp ~/dotfiles/tigrc ~/.tigrc
cp ~/dotfiles/zimrc ~/.zimrc
cp ~/dotfiles/bashrc ~/.bashrc

sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen
locale-gen
update-locale LANG=ja_JP.UTF-8

mkdir -p ~/.cache/zim
rm -rf ~/.cache/zim

git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
bash ~/.bash_it/install.sh --silent
