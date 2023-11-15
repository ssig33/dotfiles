#!/bin/sh

# exit unless on REMOTE_CONTAINERS or CODESPACES
if [ -z "$CODESPACES" ] && [ -z "$REMOTE_CONTAINERS" ]; then
    echo "You must be on a REMOTE_CONTAINERS or CODESPACES to run this script."
    exit 1
fi


# exit unless distro is Debian
if [ -z "`which apt-get`" ]; then
    echo "You must be on a Debian-based distro to run this script."
    exit 1
fi

# use sudo if not root
if [ "$EUID" -ne 0 ]; then
    SUDO=sudo
fi

# install packages
if [ "$(id -u)" -eq 0 ]; then
    bash apt.sh
else
    sudo bash apt.s
fi

cp ./zshrc ~/.zshrc
cp ./tigrc ~/.tigrc
cp ./zimrc ~/.zimrc
cp fuckgit /usr/local/bin

sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen
sed -i -E 's/# (en_US.UTF-8)/\1/' /etc/locale.gen
locale-gen
update-locale LANG=ja_JP.UTF-8

mkdir -p ~/.cache/zim
rm -rf ~/.cache/zim

git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
bash ~/.bash_it/install.sh --silent -f

cat ./bashrc >> ~/.bashrc

# replace bobby theme with powerline
sed -i -E 's/^\s*export BASH_IT_THEME=.*/export BASH_IT_THEME="powerline"/' ~/.bashrc
