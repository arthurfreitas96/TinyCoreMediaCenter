# TinyCoreMediaCenter

## About

This folder contains all configuration files from my Tiny Core Media Center project. This Media Center has a torrent client that can be accessed locally and remotely and can stream the media downloaded to all the devices connnected to the same local network.

The setup is composed by Tiny Core O.S. version 5.2., Transmission's BitTorrent client and Rygel, that implements the UPnP streaming function (you can access the media via VLC, in View/Playlist/Local Network/Universal Plug n' Play). The project also implements static ip to the Media Center. The configuration files that made posible this setup are stored in dedicated folders.

Before proceding, be sure to have your pc running on Tiny Core 5.2. and to install Transmission and Rygel to it. Don't forget to first run the transmission-daemon to generate the configuration files for Transmission. If your home gateway doesn't support DDNS, be sure to install also cron.tcz, bash.tcz and to copy, via usb stick, the bashNoIpUpdater folder to your preferred location.

## File Locations

folder: os/
	bootlocal.sh -> /opt &
	.filetool.lst -> /opt

folder: staticIP/
	eth0.sh -> /opt

folder: transmission/
	settings.json -> use it as settings file for Transmission. Remember to make the Transmission's configuration folder to be persistent, so it can safely store your torrent files.

folder: rygel/
	rygel.conf -> use it as settings file for Rygel.

(If your gateway doesn't support DDNS: folder: bashNoIpUpdater (provided by https://github.com/LasTechLabs/wake-without-WOL/ )/
	noipupdater.sh &
	config -> both files need to be in a same folder
	
(If your pc doesn't support Wake-on-Lan: folder: MCRemoteControl/
	MCRemoteControl.ino -> this sketch allows to turn on and off the Media Center remotely, and is not used in the Media Center setup, but in the optional implementation including a NodeMCU board. Read more below.)


## Steps

In OS's bootlocal.sh, set the Transmission's config folder to the path defined by transmission-daemon on first run.

In staticIP's eth0.sh, set your Media Center and gateway IP's.

In Transmission's setting.conf, define the download-dir, rpc-username and rpc-password to be used in your setup.

In Rygel's rygel.conf, set, in '[MediaExport]', your uris to the same path defined in Transmission's download-dir.

(If your gateway doesn't support DDNS: in bashNoIpUpdater's config, set your DDNS host name service's username (email), password, host name and path to store the access logs. The logs inform you about noipupdater.sh activity.)

## Observations

To remotely access the torrent client, remember to create a host name (for example, a free one provided by https://www.noip.com/) for your Media Center and to port foward in your gateway (Transmission's default port is 9091). If your gateway supports DDNS, you are good to go. You can access the Media Center connecting to hostname:9091 (remember to set the host name in the gateway's DDNS settings).

However, if your gateway doesn't support DDNS, you can update your public ip to your host name using the bash script located in bashNoIpUpdater folder. You can also update your host name with a defined frequency (warning: updating excessively can ban you from the no-ip api). It's possible to define such frequency using cron.
For instance, you can run 'crontab -e' and set '* */3 * * * bash /home/tc/your-path/noipupdater.sh' to run the updater once in every 3 hours (read cron documentation or simply visit https://crontab.guru/).

If you have interest in turning on and off your Media Center remotely, search for Wake-on-Lan (if your pc supports it). Alternatively, https://github.com/LasTechLabs/wake-without-WOL/, if your pc supports wake up by timer (RTC). You can also turn your pc on and off remotely using a NodeMCU board and a relay module and setting your pc, if it supports, to automatically start when connected to the electrical grid. In this project, the last solution was adopted and the sketch to the NodeMCU board is included inside the MCRemoteControl folder.

In this project, the Media Center was implemented headlessly, but it's system was set to be controllled remotely via SSH, according to https://iotbytes.wordpress.com/configure-ssh-server-on-microcore-tiny-linux/.
