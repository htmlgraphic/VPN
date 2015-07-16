#!/bin/bash

git clone https://github.com/SoftEtherVPN/SoftEtherVPN.git /usr/local/src/vpnserver

cd /usr/local/src/vpnserver

cp src/makefiles/linux_64bit.mak Makefile
make

cp bin/vpnserver/vpnserver /opt/vpnserver
cp bin/vpnserver/hamcore.se2 /opt/hamcore.se2/etc/environment
cp bin/vpncmd/vpncmd /opt/vpncmd

rm -rf /usr/local/src/vpnserver

gcc -o /usr/local/sbin/run /usr/local/src/run.c

rm /usr/local/src/run.c

yum -y remove readline-devel ncurses-devel openssl-devel \
  && yum -y groupremove "Development Tools" \
  && yum clean all

# Set Proxy vars
cat /env >> /etc/environment

exit 0
