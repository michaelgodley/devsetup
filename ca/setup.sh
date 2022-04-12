#!/bin/bash
# set -x

sudo apt update
sudo apt upgrade -y

source $(dirname "$0")/../scripts/libs.sh

aptinstall openvpn
aptinstall easy-rsa
