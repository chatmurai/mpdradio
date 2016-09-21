#!/usr/bin/env python2.7
import os
import RPi.GPIO as GPIO
import atexit
import time
GPIO.setmode(GPIO.BOARD)

GPIO.setup(5, GPIO.OUT) # ready LED
GPIO.setup(15, GPIO.IN, pull_up_down = GPIO.PUD_UP) # volume up
GPIO.setup(13, GPIO.IN, pull_up_down = GPIO.PUD_UP) # volume down
GPIO.setup(11, GPIO.IN, pull_up_down = GPIO.PUD_UP) # next station
GPIO.setup(7, GPIO.IN, pull_up_down = GPIO.PUD_UP) # prev station

# Register exit routine
def finish():
    GPIO.output(5, GPIO.LOW)
    GPIO.cleanup()
    print("Radio stopped")

atexit.register(finish)

# light ready led on
GPIO.output(5, GPIO.HIGH)

# Execute system command sub-routine
def exec_command(cmd):
    result = ""
    p = os.popen(cmd)
    return p.read()

# Listen for GPIO change
def onChange(channel):
    if channel == 15:
        print(exec_command("mpc volume +10"))
    elif channel == 13:
        print(exec_command("mpc volume -10"))
    elif channel == 11:
        print(exec_command("mpc prev"))
    elif channel == 7:
        print(exec_command("mpc next"))

try:
    GPIO.add_event_detect(15, GPIO.RISING, callback=onChange, bouncetime=500)
    GPIO.add_event_detect(13, GPIO.RISING, callback=onChange, bouncetime=500)
    GPIO.add_event_detect(11, GPIO.RISING, callback=onChange, bouncetime=500)
    GPIO.add_event_detect(7, GPIO.RISING, callback=onChange, bouncetime=500)
except KeyboardInterrupt:
    GPIO.cleanup()

while True:
    time.sleep(1)
