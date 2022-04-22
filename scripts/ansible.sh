#!/bin/bash

# source some env variables
. ../config.conf
. ./libs.sh

aptinstall software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
aptinstall ansible

