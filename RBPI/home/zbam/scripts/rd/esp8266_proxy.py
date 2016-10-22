#!/usr/bin/env/python
# coding: utf-8

import serial
import re
import json
import os

# regexp for matching any string between four #### chars
reg = re.compile(ur'~~~~(.*)~~~~')

# /dev/ttyACM0 for GPIO UART pins
ser = serial.Serial(

               port='/dev/ttyUSB0',
               baudrate = 9600,
               parity=serial.PARITY_NONE,
               stopbits=serial.STOPBITS_ONE,
               bytesize=serial.EIGHTBITS
           )

def is_json(myjson):
    try:
        json_object = json.loads(myjson)
    except ValueError, e:
        return False
    return True

def update_wpa_supplicant(ssid, psk):
    print "updating wpa_supplicant.conf…"
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
    print "restarting wifi interface…"
    os.system("sudo ifdown wlan0 && sudo ifup wlan0")
    print "done." #TODO : envoyer ok à l'Esp8266 qui transmettra à l'appli si tout c'est bien passé

def rot47(s):
    x = []
    for i in xrange(len(s)):
        j = ord(s[i])
        if j >= 33 and j <= 126:
            x.append(chr(33 + ((j + 14) % 94)))
        else:
            x.append(s[i])
    return ''.join(x)

while True:
    	data=rot47(ser.readline()) # we decrypt and read the content of the line received ont the RX USB UART module
    	if len(re.findall(reg, data)) > 0: # Then if the length of the array containing the data extracted is > 0
                jsonData = re.findall(reg, data)[0]
                if is_json(jsonData):
                    parsed_json = json.loads(jsonData)
                    update_wpa_supplicant(parsed_json['ssid'], parsed_json['psk'])
