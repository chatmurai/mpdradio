sudo raspi-config
sudo rpi-update
sudo apt-get install rpi-update
sudo apt-get install --fix-missing rpi-update
sudo apt-get update
clear
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
sudo reboot
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install rpi-update
sudo rpi-update
sudo halt
clear
top
sudo halt
ls
cd ..
ls
cd ..
ls
cd home/pi/
ls
clear
mpd
sudo passwd root
logout
sudo nano /etc/ssh/sshd_config
sudo reboot
sudo nano /etc/ssh/sshd_config
sudo passwd -l root
sudo apt-get install mpd mpc alsa-utils
apt-get install lame flac faad vorbis-tools
sudo apt-get install lame flac faad vorbis-tools
sudo passwd root
sudo nano /etc/ssh/sshd_config
sudo reboot
ifconfig
mkdir /home/zbam/.mpd && mkdir /home/zbam/.mpd/playlists
cd /home/zbam//.mpd/
ls
touch mpd.log pid state sticker.sql
ls
mpc update
service mpd restart
sudo service mpd restart
mpc update
groups zbam
sudo service mpd restart
sudo reboot
top
sudo service mpd restart
sudo raspi-config
amixer set PCM -- 100%
sudo reboot
clear
logout
sudo rm /etc/motd
sudo nano /etc/motd
logout
sudo halt
mpc next
next
mpc next
mpc stop
sudo raspi-config
mpc play
mpc setvol 50
mpc help
mpc volume 50
mpc volume 100
mpc next
ifconfig
mpc next
logout
mpc status
mpc play
mpc stop
mpc play
mpc stop
sudo halt
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
sudo halt
ping google.com
ifconfig
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
clear
sudo halt
ping google.com
mpc play
sudo raspi-config
sudo halt
mpc next
mpc previous
mpc prev
mpc next
mpc prev
mpc next
alsamixer
mpc prev
sudo halt
sudo apt-get install autoconf libtool libdaemon-dev libasound2-dev libpopt-dev libconfig-dev
sudo apt-get install avahi-daemon libavahi-client-dev
sudo apt-get install libssl-dev
cd ~
git clone https://github.com/mikebrady/shairport-sync.git
sudo apt-get install git
git clone https://github.com/mikebrady/shairport-sync.git
cd shairport-sync
autoreconf -i -f
./configure --with-alsa --with-avahi --with-ssl=openssl
make
sudo make install
sudo nano /etc/init.d/shairport-sync
ps aux | grep systemd | grep -v grep
./configure --with-alsa --with-avahi --with-ssl=openssl --with-metadata --with-systemd
make
getent group shairport-sync &>/dev/null || sudo groupadd -r shairport-sync >/dev/null
getent passwd shairport-sync &> /dev/null || sudo useradd -r -M -g shairport-sync -s /usr/bin/nologin -G audio shairport-sync >/dev/null
sudo make install
sudo systemctl enable shairport-sync
sudo nano /etc/init.d/shairport-sync
sudo nano /etc/shairport-sync.conf
ls
cd ~
ls
mkdir scripts
cd scripts/
sudo nano mpdstop.sh
sudo nano mpdplay.sh
chmod +x mpdstop.sh 
sudo chmod +x mpdstop.sh 
sudo chmod +x mpdplay.sh 
shairport-sync start
sudo reboot
sudo halt
cd scr
ls
cd scrip
cd scripts/
ls
mpc volume
mpc current
cd rd
ls
sudo python ledblink.py 
sudo nano /etc/rc.local 
sudo reboot
sudo nano /etc/rc.local 
sudo reboot
top
sudo nano /etc/rc.local 
sudo reboot
top
top python
logout
cd scripts/
top
sudo python buttons.py 
sudo nano /etc/rc.local 
sudo reboot
top
sudo reboot
top
w
date
uptime
tload
w
ps
ps -ef
ps -ejH
ps -u root
top
sudo kill 677
sudo reboot
ps -ef
ps -ef | python
ps -ef | grep python
sudo kill 657
sudo python scripts/buttons.py 
sudo python scripts/buttons.py &
ps -ef | grep python
sudo reboot
ps -ef | grep python
sudo halt
sudo reboot
ps
ps root
ps -u root
ps -ef | grep mpd
sudo reboot
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
sudo ifdown eth0
sudo reboot
ping 8.8.8.8
ping 192.168.0.254
ls
sudo halt
sudo reboot
nano /etc/wpa_supplicant/wpa_supplicant.conf 
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf 
apt-cache policy raspberrypi-net-mods
cd /etc/wpa_supplicant/
ls
ln -s /boot/wpa_supplicant.conf wpa_supplicant.conf
sudo ln -s /boot/wpa_supplicant.conf wpa_supplicant.conf
sudo reboot
ifconfig
iwconfig
sudo halt
iwconfig
cd /etc/wpa_supplicant/
ls
sudo nano wpa_supplicant.conf 
rm wpa_supplicant.conf 
sudo rm wpa_supplicant.conf 
ls
ls -s /boot/wifi/setup.txt wpa_supplicant.conf
sudo ls -s /boot/wifi/setup.txt wpa_supplicant.conf
ls
sudo ln -s /boot/wifi/setup.txt wpa_supplicant.conf
rm /boot/wpa_supplicant.conf 
sudo rm /boot/wpa_supplicant.conf 
sudo reboot
cd /etc/wpa_supplicant/
ls
rm wpa_supplicant.conf 
sudo rm wpa_supplicant.conf 
mv _wpa_supplicant.conf wpa_supplicant.conf
sudo mv _wpa_supplicant.conf wpa_supplicant.conf
iwconfig
sudo ifdown wlan0
sudo reboot
iwconfig
ping 192.168.0.254
sudo reboot
mpc status
mpc play
ln -s /boot/wifi.conf /etc/wpa_supplicant/wpa-supplicant.conf
sudo ln -s /boot/wifi.conf /etc/wpa_supplicant/wpa-supplicant.conf
sudo reboot
ping 192.168.0.254
iwconfig
cd /etc/wpa_supplicant/
ls
rm wpa-supplicant.conf 
sudo rm wpa-supplicant.conf 
ls
cd /boot
ls
mv wifi.conf wpa_supplicant.conf
sudo mv wifi.conf wpa_supplicant.conf
ls
cd /etc/wpa_supplicant/
sudo ln -s /boot/wpa_supplicant.conf wpa_supplicant.conf
iwconfig
sudo ifup wlan0
sudo reboot
mpc play
ping 192.168.0.254
iwconfig
cd /boot
ls
sudo nano wpa_supplicant.conf 
cd /etc/wpa_supplicant/
ls
sudo rm wpa_supplicant.conf 
sudo ln -s /boot/wpa_supplicant.conf wpa_supplicant.conf
sudo reboot
iwconfig
mpc play
mpd restart
sudo reboot
mpc status
mpc currentsong
mpd currentsong
mpc listplaylist
mpc lsplaylist
mpc lsplaylists
mpc ls
mpc listall
mpc stop
mpc play
logout
sudo reboot
logout
sudo halt
mpc currentsong
mpd currentsong
logout
sudo raspi-config
sudo halt
sudo raspi-config
sudo halt
ls
cd scripts/
ls
python serial.py 
sudo reboot
cd scripts/
python arduino_proxy.py 
sudo pip uninstall pyserial
sudo apt-get install python-serial
python arduino_proxy.py 
dmesg
sudo apt-get install python-serial3
sudo apt-get install python3-serial
python arduino_proxy.py 
python3 arduino_proxy.py 
sudo apt-get remove python-serial3
sudo apt-get remove python3-serial
python arduino_proxy.py 
sudo raspi-config
cd scripts/
python arduino_proxy.py 
sudo nano /etc/inittab
ls /dev/tty*
sudo nano /etc/inittab
sudo nano /boot/cmdline.txt
ps aux | grep ttyAMA0
sudo kill 723
ps aux | grep ttyAMA0
stty -F /dev/ttyAMA0 -a
sudo nano /etc/init.d/
sudo nano /etc/rc.local 
sudo reboot
stty -F /dev/ttyAMA0 -a
cd scripts/
ps aux | grep ttyAMA0
dmesg | tail
python arduino_proxy.py 
sudo nano /etc/rc.local 
sudo reboot
cd scripts/
python arduino_proxy.py
logout
cd scripts/
ls
mv arduino_proxy.py esp8266_proxy.py
ls
python esp8266_proxy.py 
where
who
python esp8266_proxy.py 
sudo reboot
cd scripts/
python esp8266_proxy.py 
sudo raspi-config
cd scrip
cd scripts/
ls
python esp8266_proxy.py 
sudo nano /etc/rc.local 
sudo reboot
cd /etc/wpa_supplicant/
ls
ln -s /etc/wpa_supplicant/wpa_supplicant.conf /home/zbam/wpa_supplicant.conf 
cd /etc/wpa_supplicant/
ls
ln -s /home/zbam/wpa_supplicant.conf wpa_supplicant.conf
sudo ln -s /home/zbam/wpa_supplicant.conf wpa_supplicant.conf
sudo reboot
aplay /home/zbam/chime.wav 
sudo nano /etc/rc.local 
sudo halt
sudo nano /etc/rc.local 
sudo reboot
cd scripts/
ls
python esp8266_proxy2.py 
sudo apt-get install python-crypto
python esp8266_proxy2.py 
sudo apt-get remove python-crypto
python esp8266_proxy2.py 
sudo apt-get install M2Crypto
sudo apt-get remove M2Crypto
sudo apt-get remove python-m2crypto
sudo apt-get install python-crypto
python esp8266_proxy2.py 
python esp8266_proxy.py 
sudo python esp8266_proxy.py 
mpd play
mpc play
mpc next
mpc previous
mpc prev
mpc next
sudo halt
