#!/usr/bin/env/python
# coding: utf-8

import serial
import re
import json
from Crypto.Cipher import AES
import base64
import os

# regexp for matching any string between 'GET /' and ' HTTP' strings
reg = re.compile(ur'(?<=GET /)(.*)(?= HTTP)')

# ------------------ Crypto
DECR_KEY = "ChAZ&G#+L$W9bE3u";
DECR_IV = "6@ctFA$mrX&U=Te!";


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
    print "updating wpa_supplicant.conf file and rebooting..."
    f = open("/home/zbam/wpa_supplicant.conf","w")
    f.write("country=FR ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev\n")
    f.write("update_config=1\n")
    f.write("\n");
    f.write("network={\n")
    f.write("   ssid=\"" + ssid + "\"\n")
    f.write("   psk=\"" + psk + "\"\n")
    f.write("}")
    f.close()
    os.system("sudo reboot")

def decrypt_aes(key, text):
    try:
        enc = base64.b64decode(text)
        iv = enc[:AES.block_size]
        #iv = '6@ctFA$mrX&U=Te!'
        cipher = AES.new(key, AES.MODE_CBC, iv)
        return _unpad(cipher.decrypt(enc[AES.block_size:]))
    except Exception as e:
        print e.message
        return text

def _pad(s):
    bs = 16
    return s + (bs - len(s) % bs) * chr(bs - len(s) % bs)

def _unpad(s):
    return s[:-ord(s[len(s) - 1:])]

while True:
    data=ser.readline() # we read the content of the line received ont the RX USB UART module
    if len(re.findall(reg, data)) > 0: # Then if the length of the array containing the data extracted is > 0
            encryptedData = re.findall(reg, data)[0]
            decrypted_data = decrypt_aes('ChAZ&G#+L$W9bE3u', encryptedData)
            print decrypted_data

'''
while True:
	data=ser.readline() # we read the content of the line received ont the RX USB UART module
	if len(re.findall(reg, data)) > 0: # Then if the length of the array containing the data extracted is > 0
            jsonData=re.findall(reg, data)[0]
            if is_json(jsonData):
                parsed_json = json.loads(jsonData)
                update_wpa_supplicant(parsed_json['ssid'], parsed_json['pass'])
'''
