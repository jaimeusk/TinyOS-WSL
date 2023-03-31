#!/bin/bash

echo "Actualizando Linux"
apt-get -y update
apt-get -y upgrade

echo "Instalando usbip..."
apt-get -y install linux-tools-generic hwdata
update-alternatives --install /usr/local/bin/usbip usbip /usr/lib/linux-tools/*-generic/usbip 20

apt-get -y install automake emacs bison flex
apt-get -y install gperf git make openjdk-8-jdk-headless
apt-get -y install gcc-msp430 g++ python3 python3-serial
apt-get -y install python python-serial

cd /opt/
git clone https://github.com/tinyos/nesc.git
cd nesc
./Bootstrap
./configure
make
make install

cd /opt/
git clone https://github.com/tp-freeforall/prod
mv prod tinyos-main
cd tinyos-main/tools/
./Bootstrap
./configure
make
make install
