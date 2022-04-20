#!/bin/bash

## For WSL only
# sudo apt remove --purge openssh-server
# sudo apt install -y openssh-server
# sudo service ssh restart

## X2GO 
sudo add_apt_repository ppa:x2gostable
sudo apt install -y x2goserver x2goserver-xsession

## Desktop
sudo apt install -y ubuntu-mate-desktop x2gomatebindings
sudo apt remove -y blueman

# sudo apt install -y xubuntu-desktop xubuntu-core
# Use lightdm


## Client
# sudo apt install x2goclient
