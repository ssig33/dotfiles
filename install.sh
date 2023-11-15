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
$SUDO apt update
$SUDO apt install -y tig locales bash-completion curl

# if node is not installed, install it
if [ -z "`which node`" ]; then
    $SUDO apt-get update && sudo apt-get install -y ca-certificates curl gnupg
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | $SUDO gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    NODE_MAJOR=18
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | $SUDO tee /etc/apt/sources.list.d/nodesource.list
    $SUDO apt-get update
    $SUDO apt-get install -y nodejs
fi

# if ruby is not installed, install it
if [ -z "`which ruby`" ]; then
    $SUDO apt-get install -y ruby ruby-dev
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
