#!/bin/bash
apt update && apt upgrade -y
apt install wget sudo nano -y
wget https://raw.githubusercontent.com/hackyannick/samba4-dc/main/dc1/interfaces.sav
rm -rf /etc/network/interfaces
cp /opt/smb_dc/interfaces.sav /etc/network/interfaces
reboot
