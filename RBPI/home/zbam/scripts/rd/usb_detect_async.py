#!/usr/bin/env python
import pyudev

context = pyudev.Context()
monitor = pyudev.Monitor.from_netlink(context)
monitor.filter_by(subsystem='usb')

def monitorUSB(action, device):
    if action == 'add':
        #print device.get('ID_MODEL_ID'), device.get('ID_VENDOR'), device.get('ID_MODEL'), device.get('ID_MODEL_FROM_DATABASE'), device.get('INTERFACE'), device.get('MODALIAS')
        #print device.get('ID_MODEL_FROM_DATABASE') + " plugged in."
        if(device.get('ID_MODEL_FROM_DATABASE') == 'HL-340 USB-Serial adapter') and (device.get('MODALIAS') is not None):
            print "plugged in"
    elif action == 'remove':
        if(device.get('ID_MODEL_FROM_DATABASE') == 'HL-340 USB-Serial adapter') and (device.get('MODALIAS') is not None):
            print "removed"

observer = pyudev.MonitorObserver(monitor, monitorUSB)
observer.start()

while 1:
    pass
