import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BOARD)
GPIO.setup(5,GPIO.OUT)

print "LED on"
GPIO.output(5,GPIO.HIGH)

time.sleep(1)

print "LED off"
GPIO.output(5,GPIO.LOW)
