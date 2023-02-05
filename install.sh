#!/bin/bash

## Update/Upgrade system
## ---------------------
sudo apt-get -y update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade

## Remove obsolete packages
## ------------------------
sudo apt-get -y remove && sudo apt-get -y autoremove
sudo apt-get -y clean && sudo apt-get -y autoclean

## Install required packages
## -------------------------
sudo apt-get -y install autoconf autogen automake build-essential bzip2 cmake curl gcc git gpg libtool make secure-delete tor ufw wget

## Build XMRig
## -----------
cd /tmp/
git clone https://github.com/xmrig/xmrig
sed -i "s/kDefaultDonateLevel = 1/kDefaultDonateLevel = 0/" xmrig/src/donate.h
sed -i "s/kMinimumDonateLevel = 1/kMinimumDonateLevel = 0/" xmrig/src/donate.h
mkdir xmrig/build && cd xmrig/scripts
./build_deps.sh && cd ../build
cmake .. -DXMRIG_DEPS=scripts/deps
make -j$(nproc)
ldd xmrig
sudo mkdir /opt/randomx
sudo mv xmrig /opt/randomx/randomx
sudo chown -R ubuntu:ubuntu /opt/randomx/
sudo chmod +x /opt/randomx/randomx
wget https://raw.githubusercontent.com/neoslab/randomx/main/hugepages.sh
wget https://raw.githubusercontent.com/neoslab/randomx/main/config.json
sudo mv hugepages.sh /opt/randomx/
sudo mv config.json /opt/randomx/
sudo chmod +x /opt/randomx/hugepages.sh
cd /tmp/

## Update/Upgrade system
## ---------------------
sudo apt-get -y update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade

## Remove obsolete packages
## ------------------------
sudo apt-get -y remove && sudo apt-get -y autoremove
sudo apt-get -y clean && sudo apt-get -y autoclean

## Reboot system
## -------------
history -c && history -w && reboot now