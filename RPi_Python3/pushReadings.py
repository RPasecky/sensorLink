import RPi.GPIO as GPIO
import sched, time
import pyrebase
import datetime
import json

GPIO.setmode(GPIO.BCM)
GPIO.setup(4,GPIO.IN)
GPIO.setup(17, GPIO.OUT)

config = {
    "apiKey": "This is where your APIKEy goes, it's super long and random",
    "authDomain": "YourProjectID.firebaseapp.com",
    "databaseURL": "https://YourProjectID.firebaseio.com",
    "storageBucket": "YourProjectID.appspot.com",
  }

firebase = pyrebase.initialize_app(config)

db = firebase.database()
datetime.date.today().strftime("%B %d, %Y")

s = sched.scheduler(time.time, time.sleep)

currentReading = False
lastReading = False

def stream_handler(message):
	
	if message["data"] == "on":
		GPIO.output(17,True)
		print("Light on")
	if message["data"] == "off":
		GPIO.output(17,False)
		print("Light off")

def takeReading(sc): 
	#currentDate = str(datetime.datetime.now())[:-7]
	global lastReading, currentReading 

	currentReading = GPIO.input(4)
	if lastReading != currentReading:
		if currentReading:
			print("You are now touching!")
			data = {"currentlyTouching": "true"}
			db.child("touch").update(data)
		else: 
			print("You are no longer touching!")
			data = {"currentlyTouching": "false"}
			db.child("touch").update(data)
		lastReading = currentReading

	s.enter(0.1, 1, takeReading, (sc,))

my_stream = db.child("light").stream(stream_handler)
s.enter(0.1, 1, takeReading, (s,))
s.run()
