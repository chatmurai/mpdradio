#!/usr/bin/env/python
# coding: utf-8

import serial
import re
import json
import os
import subprocess
import re
import threading
from datetime import datetime

# regexp for matching any string between four ~ chars
reg = re.compile(ur'~~~~(.*)~~~~')

# /dev/ttyACM0 for GPIO UART pins
ser = serial.Serial(

               port='/dev/ttyUSB0',
               baudrate = 115200,
               parity=serial.PARITY_NONE,
               stopbits=serial.STOPBITS_ONE,
               bytesize=serial.EIGHTBITS
           )

def update_wpa_supplicant(ssid, psk):
    """Updates /home/zbam/wpa_supplicant.conf file with wifi credentials received from
    client app and then restart tinterfaces"""

    print "Try to update wpa_supplicant.conf…"

    try:
        f = open("/home/zbam/wpa_supplicant.conf","w")
        f.write("country=FR ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev\n")
        f.write("update_config=1\n")
        f.write("\n");
        f.write("network={\n")
        f.write("   ssid=\"" + ssid + "\"\n")
        f.write("   psk=\"" + psk + "\"\n")
        f.write("}")
        f.close()
        #os.system("sudo reboot")
        print "restarting wifi wlan0 interface…"
        if os.system("sudo ifdown wlan0 && sudo ifup wlan0") == 0:
            ser.write("s_wi-cr_ok\n");
            print "Wifi credentials successfully updated."
        else:
            ser.write("s_wi-cr_ok_error\n");
            print "error while restarting wifi wlan0 interface…"
    except:
        ser.write("s_wi-cr_ok_error\n");
        print "error while updating wpa_supplicant.conf file"

def rot47(s):
    """Encodes & decodes string to and from ROT47 algorithm"""
    x = []
    for i in xrange(len(s)):
        j = ord(s[i])
        if j >= 33 and j <= 126:
            x.append(chr(33 + ((j + 14) % 94)))
        else:
            x.append(s[i])
    return ''.join(x)

def getWifiNetworks():
	"""Renvoie un JSON contenant les information des réseaux wifi disponibles"""
	proc = subprocess.Popen('sudo iwlist wlan0 scan 2>/dev/null', shell=True, stdout=subprocess.PIPE, )
	stdout_str = proc.communicate()[0]
	stdout_list = stdout_str.split('\n')

	networks = []
	network = {}

	for line in stdout_list:
		line = line.strip()
		match = re.search('Address: (\S+)',line)
		if match:
			if len(network):
				networks.append(network)
			network = {}
			#network["mac"] = match.group(1)

		match = re.search('ESSID:"(\S+)"',line)
		if match:
			network["s"] = match.group(1)

	    # Quality=100/100  Signal level=72/100
		match = re.search('Quality=([0-9]+)\/([0-9]+)[ \t]+Signal level=([0-9]+)\/([0-9]+)',line)
		if match:
			#network["quality"] = match.group(1)
			#network["quality@scale"] = match.group(2)
			network["d"] = match.group(3)

		# Encryption key:on
		match = re.search('Encryption key:(on|.+)',line)
		if match:
			network["e"] = "1" if match.group(1) == "on" else "0"

	if len(network):
		networks.append(network)

	return json.dumps(networks, separators=(',', ':'))

def sendWifiNetworksInfoToEsp8266():
    networks = getWifiNetworks()
    #print networks
    ser.write(networks + "\n")
    print "WifiNetworks info sent to Esp8266"

while True:
        data = ser.readline()
        #print(data)
        if data.find("g_wi-sc") != -1:
            print "wifi networks request from Esp8266"
            sendWifiNetworksInfoToEsp8266()
        elif data.find("s_wi-cr") != -1:
            print "wifi credentials receive from Esp8266"
            jsonData = json.loads(rot47(re.findall(reg, data)[0]))
            update_wpa_supplicant(jsonData['ssid'], jsonData['psk'])
