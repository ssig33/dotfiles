apt update
apt install -y tig locales bash-completion curl

# if node is not installed, install it
if [ -z "`which node`" ]; then
    apt-get update && sudo apt-get install -y ca-certificates curl gnupg
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    NODE_MAJOR=18
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
    apt-get update
    apt-get install -y nodejs
fi

# if ruby is not installed, install it
if [ -z "`which ruby`" ]; then
    apt-get install -y ruby ruby-dev
fi

sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen
sed -i -E 's/# (en_US.UTF-8)/\1/' /etc/locale.gen
locale-gen
update-locale LANG=ja_JP.UTF-8
