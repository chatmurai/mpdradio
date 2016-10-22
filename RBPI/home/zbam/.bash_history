sudo raspi-config
sudo halt
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf 
sudo halt
sudo apt-get update
sudo apt-get upgrade
sudo reboot
sudo passwd root
sudo nano /etc/ssh/sshd_config
logout
sudo passwd root
sudo reboot
sudo passwd -l root
sudo nano /etc/ssh/sshd_config
sudo reboot
apt-get install mpd mpc alsa-utils
sudo apt-get install mpd mpc alsa-utils
sudo apt-get install lame flac faad vorbis-tools
sudo nano /etc/mpd.conf
sudo nano /etc/ssh/sshd_config
/etc/init.d/ssh restart
sudo /etc/init.d/ssh restart
sudo reboot
sudo nano /etc/ssh/sshd_config
sudo passwd root
mkdir /home/zbam/.mpd && mkdir /home/zbam/.mpd/playlists
cd /home/zbam/.mpd
touch mpd.log pid state sticker.sql
mpc update
aplay -l
sudo halt
top
sudo halt
mpc loaradios.m3u
cd .mpd/
ls
cd playlists/
mpc load radios.m3u
ls
mpc lsplaylists
mpc load radios
mpc play
mpc setvol 100
mpc volume 100
mpc volume 10
mpc volume 100
amixer  sset PCM,0 95%
mpc stop
amixer  sset PCM,0 99%
amixer  sset PCM,0 95%
mpc play
sudo reboot
mpc prev
mpc next
logout
sudo apt-get install autoconf libtool libdaemon-dev libasound2-dev libpopt-dev libconfig-dev
sudo apt-get install avahi-daemon libavahi-client-dev
sudo apt-get install libssl-dev
sudo apt-get install git
ls
wget https://github.com/mikebrady/shairport-sync/archive/master.zi
ls
tar -xzvf master.zip
sudo apt-get install unzip
ls
unzip master.zip 
ls
rm master.zip 
cd shairport-sync-master/shairport-sync
cd shairport-sync-master
ls
autoreconf -i -f
./configure --with-alsa --with-avahi --with-ssl=openssl
make
sudo make install
sudo nano /etc/init.d/shairport-sync
sudo nano /etc/shairport-sync.conf
ps aux | grep systemd | grep -v grep
./configure --with-alsa --with-avahi --with-ssl=openssl --with-systemd
make
sudo make install
sudo update-rc.d shairport-sync defaults 90 10
sudo nano /etc/init.d/shairport-sync
sudo nano /etc/rc.d/
sudo reboot
top
sudo systemctl enable shairport-sync
sudo reboot
top
mpc stop
sudo nano /etc/init.d/shairport
sudo nano /etc/init.d/shairport-sync
systemctl is-active shairport-sync
systemctl status shairport-sync
systemctl start shairport-sync
sudo systemctl start shairport-sync
cd shairport-sync-master/
ls
autoreconf -i -f
ps aux | grep systemd | grep -v grep
./configure --with-alsa --with-avahi --with-ssl=openssl --with-metadata --with-systemd
getent group shairport-sync &>/dev/null || sudo groupadd -r shairport-sync >/dev/null
getent passwd shairport-sync &> /dev/null || sudo useradd -r -M -g shairport-sync -s /usr/bin/nologin -G zbam shairport-sync >/dev/null
getent passwd shairport-sync &> /dev/null || sudo useradd -r -M -g shairport-sync -s /usr/bin/nologin -G audio shairport-sync >/dev/null
sudo make install
sudo reboot
sudo nano /etc/init.d/shairport-sync
shairport-sync -h
alsamixer
aplay
alsamixer
systemctl restart shairport-sync.service
sudo systemctl restart shairport-sync.service
cd ~
sudo chmod
mpd play
mpc play
ls
mkdir test
cd test
cd ..
rmdir test
ls
mkdir ~/zouzou && nano ~/scripts/toto.sh
mpc play
mpc next
mpc prev
mpc repeat on
mpc prev
mpc next
mpc next getcurrentsong
mpc next | getcurrentsong
mpc next | currentsong
mpc next
mpc currentsong
ifconfig
sudo python ~/scripts/esp8266_proxy.py 
sudo apt-get install python-serial
sudo python ~/scripts/esp8266_proxy.py 
iwlist
iwconfig
sudo python ~/scripts/esp8266_proxy.py 
sudo mv /etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/_wpa_supplicant.conf
ln -s ~/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
sudo ln -s ~/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf
sudo reboot
iwconfig
nano /etc/rc.local
sudo nano /etc/rc.local
python ~/scripts/esp8266_proxy.py 
iwconfig
sudo nano /etc/rc.local
mpc play
mpc next
sudo reboot
cd scripts/
ls
python esp8266_proxy3.py 
sudo reboot
top
mpc play
sudo reboot
cd scripts/
python esp8266_proxy3.py 
iwlist scan
nano ../wpa_supplicant.conf 
sudo reboot
cd scripts/
iwlist scan
python esp8266_proxy3.py 
iwlist scan
sudo halt
cd scripts/
python esp8266_proxy3.py 
sudo python esp8266_proxy3.py 
mpc play
sudo python esp8266_proxy3.py 
sudo reboot
sudo nano wpa_supplicant.conf 
sudo ifdown wlan0 && sudo ifup wlan0
iwconfig
mpc next
ping 8.8.8.8
ping 192.168.0.254
mpc stop
mpc play
mpc next
mpc stop
mpc next
mpc play
mpc next
mpc play
mpc prev
mpc next
sudo reboot
mpc next
sudo reboot
mpc next
logout
uname -a
mpc next
mpc stop
mpc load radios
mpc next
sudo reboot
mpc play
mpc next
mpc prev
sudo reboot
mpc status
mpc next
mpc status
mpc play 0
mpc play 1
mpc play 2
mpc play 3
mpc play 4
mpc play 5
mpc play 6
mpc play 7
mpc play 8
mpc stop
service mpc stop
sudo service mpd stop
mpc play
sudo service mpd start
mpc play
mpc play 0
mpc play 1
mpc stop
mpd load radios
mpc load radios
mpc play 0
sudo service mpd stop
sudo service mpd play
sudo service mpd start
sudo service mpd force-relaod
mpc play 0
mpc play 1
sudo reboot
mpc
mpc listall
mpc playlist
mpc clear
mpc load radios
mpc play
mpc next
mpc clear
mpc playlist
mpc load radio
mpc load radios
mpc playlist
mpc play
mpc repeat
mpc repeat on
mpc clear
mpc load radios
mpc play
mpc next
mpc clear
mpc load radios
mpc playlist
mpc repeat
mpc repeat on
mpc play 0
mpc next
mpc clear
mpc load radios
mpc play 0
mpc next
mpc play 0
mpc play 1
mpc play 0
mpc prev
mpc next
clear
mpc next
cd scripts/
ls
sudo python esp8266_proxy3.py 
clear
sudo python esp8266_proxy3.py 
iwconfig
sudo python esp8266_proxy3.py 
iwconfig
sudo python esp8266_proxy3.py 
sudo reboot
cd scripts/
sudo python esp8266_proxy3.py 
sudo python esp8266_proxy3.py &
logout
mpc play
cd scripts/
sudo python esp8266_proxy3.py &
sudo kill 1217
sudo python esp8266_proxy3.py
cd rd/
sudo python usb_detect.py 
sudo pip install glib
ls /dev
'ls /dev   | grep 'usb0'
cd scripts/
cd  rd/
sudo python usb_detect.py 
sudo pip install python -v
python -v
python
sudo apt-get install python-usb
sudo python usb_detect.py 
sudo apt-get remove python-usb
lsusb
sudo reboot
clear
cd scripts/
ls
sudo python esp8266_proxy3.py 
lsusb
ifoncfig
ifconfig
iwconfig
sudo python esp8266_proxy3.py 
sudo reboot
cd scripts/
sudo python rd/usb_detect.py 
sudo python esp8266_proxy4.py 
clear
sudo python esp8266_proxy4.py 
sudo python esp8266_proxy3.py 
sudo reboot
