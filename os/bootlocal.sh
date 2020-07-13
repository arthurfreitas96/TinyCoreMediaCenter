#!/bin/sh
# put other system startup commands here
#turn off screen after one minute of inactivity
echo -e '\033[9;1]'
#set baud rates for transmission
sysctl -p /etc/sysctl.conf
#define static ip
opt/eth0.sh
#start dbus to use rygel
sudo /usr/local/etc/init.d/dbus start
#to use cron, uncomment if you need it
#crond -L /dev/null 2>&1
#set your path to transmission-daemon configuration
#mine is /home/tc/apps/trans/config
transmission-daemon -g /mnt/sda1/transmission &
rygel --config=home/tc/.config/rygel.conf &
