#!/bin/sh
#kill dhcp client for eth0
if[-f/var/run/udhcpc.eth0.pid];then kill `cat /var/run/udhcpc.eth0.pid`
sleep 0.1
#configure interface eth0
#set your media center and gateway ips, mine is mediacenter: 192.168.25.13 and gateway: 192.168.25.1
ifconfig eth0 192.168.25.13 netmask 255.255.255.0 broadcast 192.168.25.255 up
route add default gw 192.168.25.1
echo nameserver 192.168.25.1 > /etc/resolv.conf
