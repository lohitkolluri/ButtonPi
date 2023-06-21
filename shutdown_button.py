import RPi.GPIO as GPIO
import subprocess

GPIO.setmode(GPIO.BCM)
GPIO.setup(gpio_pin, GPIO.IN, pull_up_down=GPIO.PUD_UP)

def shutdown(channel):
    subprocess.call(['sudo', 'shutdown', '-h', 'now'], shell=False)

GPIO.add_event_detect(gpio_pin, GPIO.FALLING, callback=shutdown, bouncetime=2000)

try:
    while True:
        pass

except KeyboardInterrupt:
    GPIO.cleanup()