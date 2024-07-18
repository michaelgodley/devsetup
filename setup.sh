#!/bin/bash
# set -x

if [ $# -ne 1 ];then
    echo Error Usage: $0 dev or $0 prod
    exit 1
fi

sudo apt update
sudo apt upgrade -y

source $(dirname "$0")/scripts/libs.sh

aptinstall sipcalc
aptinstall figlet
aptinstall lolcat
aptinstall htop
aptinstall screen
aptinstall hwinfo
aptinstall httpie
aptinstall bat
sudo ln -s /usr/bin/batcat /usr/local/bin/bat


if [[ "$1" == "dev" ]]; then
    echo "Setup Development Environment"
    aptinstall git
    aptinstall make
    #aptinstall emacs
    aptinstall jq
    aptinstall git-flow
    aptinstall rustc
    aptinstall golang-go
    aptinstall ansible
    aptinstall goaccess
    cargo install exa
    cargo install git-delta
    cargo install du-dust
    cargo install broot
    cargo install fd-find
    cargo install ripgrep
    cargo install gping
    cargo install procs
    linkDotfile .gitmessage
    linkDotfile .gitconfig
    linkDotfile .screenrc
    # ./programs.sh dev
    npminstall yo
    npminstall gtop
elif [[ "$1" == "prod" ]]; then
    echo "Setup Production Environment"
    ./programs.sh prod
fi

# Print Complete
figlet "... install complete!" | lolcat


