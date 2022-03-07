#!/bin/bash
# set -x

if [ $# -ne 1 ];then
    echo Error Usage: $0 dev or $0 prod
    exit 1
fi

sudo apt update
sudo apt upgrade -y

source $(dirname "$0")/scripts/libs.sh

aptinstall figlet
aptinstall lolcat
aptinstall htop

if [[ "$1" == "dev" ]]; then
    echo "Setup Development Environment"
    aptinstall screen
    aptinstall git
    aptinstall make
    #aptinstall emacs
    aptinstall jq
    aptinstall git-flow
    aptinstall rustc
    aptinstall golang-go
    aptinstall ansible
    linkDotfile .gitmessage
    linkDotfile .gitconfig
    linkDotfile .screenrc
    ./programs.sh dev
    npminstall yo
elif [[ "$1" == "prod" ]]; then
    echo "Setup Production Environment"
    ./programs.sh prod
fi

# Print Complete
figlet "... install complete!" | lolcat


