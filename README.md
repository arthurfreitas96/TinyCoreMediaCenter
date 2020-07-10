# TinyCoreMediaCenter

## About

This folder contains all configuration files from my Tiny Core Media Center project. This Media Center has a torrent client that can be accessed locally and remotely and can stream the media downloaded to all the devices connnected to the same local network.

The setup is composed by Tiny Core O.S. version 5.2., Transmission bittorrent client and Rygel, that implements the streaming function. The project also implements static ip to the Media Center. The configuration files that made posible this setup are stored in dedicated folders.

Before proceding, be sure to install Transmission and Rygel. Don't forget to first run the transmission-daemon to generate the configuration files for Transmission. If your home gateway has no DDNS server, be sure to install also cron.tcz, bash.tcz and to copy, via usb stick, the bashNoIpUpdater folder to your preferred location.

## File Locations

folder: os/
	bootlocal.sh -> /opt &
	.filetool.lst -> /opt

folder: staticIP/
	eth0.sh -> /opt

folder: transmission/
	settings.json -> overwrites the file with the same name generated by transmission-daemon on first run &
	sysctl.conf -> /etc

folder: rygel/
	rygel.conf -> overwrites original home/tc/.config/regel.conf

folder: bashNoIpUpdater (provided by https://github.com/LasTechLabs/wake-without-WOL/ )/
	noipupdater.sh &
	config -> both files need to be in a same folder
	
(folder: MCRemoteControl/
	MCRemoteControl.ino -> this sketch allows to turn on and off the Media Center remotely, and is not used in the Media Center setup, but in the optional configuration including a NodeMCU board. Read more below.)


## Steps

In OS's bootlocal.sh, set the Transmission's config folder to the path defined by transmission-daemon on first run.

In staticIP's etho0.sh, set your Media Center and gateway IP's.

In Transmission's setting.conf, define the download-dir, rpc-username and rpc-password to be used in your setup.

In Rygel's rygel.conf, set, in '[MediaExport]', your uris to the same path defined in Transmission's download-dir.

In bashNoIpUpdater's config, set your DDNS host name service's username (email), password, host name and path to store the access logs. The logs inform you about noipupdater.sh activity.

## Observations

To remotely access the torrent client, remember to create a host name (for example, a free one provided by https://www.noip.com/) for your Media Center and port foward in your gateway (Transmission's default port is 9091). If your gateway has a DDNS server, you are good to go. You can access the Media Center connecting to hostname:9091 (remember to set the host name in the gateway's DDNS server).

However, if your gateway has no DDNS server, you can update your public ip to yout host name using the bash script located in bashNoIpUpdater folder. You can also update your host name with a defined frequency (warning: updating excessively can ban you from the no-ip api). It's possible to define such frequency using cron.
For instance, you can run 'crontab -e' and set '* */3 * * * bash /home/tc/your-path/noipupdater.sh' to run the updater once in every 3 hours (read cron documentation or simply visit https://crontab.guru/).

If you have interest in turning on and off your Media Center remotely, search for Wake-on-Lan (if your pc supports it). Alternatively, https://github.com/LasTechLabs/wake-without-WOL/, if your pc supports wake up by timer (RTC). You can also turn your pc on and off remotely using a NodeMCU board and a relay module and setting your pc, if it supports, to automatically start when connected to the electrical grid. In this project, the last solution was adopted and the sketch to the NodeMCU board is included inside the MCRemoteControl folder.
