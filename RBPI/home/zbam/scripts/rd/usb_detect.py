#!/usr/bin/env python
import pyudev

context = pyudev.Context()
monitor = pyudev.Monitor.from_netlink(context)
monitor.filter_by(subsystem='usb')

hL340PluggedIn = False

def checkForhL340PluggedIn():
    for device in context.list_devices():
        if(device.get('ID_MODEL_FROM_DATABASE') == 'HL-340 USB-Serial adapter') and (device.get('MODALIAS') is not None):
            hL340PluggedIn = True
            print "oui"
            break
        else:
            hL340PluggedIn = False
            print "non"
    print hL340PluggedIn



def watchForHL340PlugChange():
    for device in iter(monitor.poll, None):
        if device.action == 'add':
            #print device.get('ID_MODEL_ID'), device.get('ID_VENDOR'), device.get('ID_MODEL'), device.get('ID_MODEL_FROM_DATABASE'), device.get('INTERFACE'), device.get('MODALIAS')
            #print device.get('ID_MODEL_FROM_DATABASE') + " plugged in."
            if(device.get('ID_MODEL_FROM_DATABASE') == 'HL-340 USB-Serial adapter') and (device.get('MODALIAS') is not None):
                hL340PluggedIn = True
                print hL340PluggedIn
        elif device.action == 'remove':
            if(device.get('ID_MODEL_FROM_DATABASE') == 'HL-340 USB-Serial adapter') and (device.get('MODALIAS') is not None):
                hL340PluggedIn = False
                print hL340PluggedIn

checkForhL340PluggedIn()
watchForHL340PlugChange()
