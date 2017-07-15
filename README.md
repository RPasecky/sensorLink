# sensorLink
This is a quick implementation of a native Swift iOS app paired with RPi Sensors through the magic of Firebase. Using this respository, you could allow 1000 people to control a light switch at the same time, or tell everyone in your contact list exactly when you are feeling bloated. The world is yours.

#### Use your phone to control your RPi GPIO

![Two way communication between pi and iphone](./Images/lightSwitch.gif)

#### Control your iPhone with your Raspberry Pi

![Two way communication between pi and iphone](./Images/touchSensor.gif)

## Before You Start:

Getting your raspberry pi and your swift app to speak to each other is surprisingly simple, however there is a fair amount of administrative work to be done before setting up the connection. 

To get this to work you need a few things:

1. A Raspberry Pi
2. Touch sensor/LEDs/Circuit prototyping tools
3. Xcode [(Preferably with a developers account)](https://developer.apple.com/programs/)
4. A Firebase account

Once you have those on hand, lets get this contraption up and running.

## Get it Working:

 This section of the guide will walk you through the steps of:

1. Setting up your circuit
2. Setting up your Firebase
3. Setting up your RPi
4. Setting up your iPhone

You may need to create a Firebase account if you don't already have one.

#### Set up your circuit!

The schematic below includes a touch sensor and an LED, the first for sending a signal, the second for displaying a recieved signal:

<img src="./Images/circuitDiagram.jpg "
   alt="download the Google plist to connect to firebase" width="800"/>


I'm sure you can come up with something more interesting...just remember to update the code accordingly! See the customization section for a more detailed walkthrough.
    
#### Get a Firebase!
    
   It's easy, [sign up here](https://firebase.google.com/). Once set up, we need some info from firebase:
   1. Click the ⚙️ -> Project Settings.

   2. Grab your Firebase's API Key and the Project ID. Keep them handy.

   3. Next, click Database. Look for a 🔗 icon near the top of the database. Copy the text next to it (that's your database URL) and keep it for later.

   4. Finally, click Storage and do the same thing. That's your Storage URL.

   With all that in order, lets set up the Raspberry Pi to start sending and recieving signals from your phone.


#### Set up your Pi!
   1. Start off by installing pyrebase into your Raspberry Pi's python 3 installation of choice:

    
        sudo pip3 install pyrebase
    
    
   ###### Warning: this could take a while, especially if your are running on a Pi Zero W like myself.
    
   2. While that's going, open up your 'RPy_python/pushReadings.py' script. There should be a section at the top that looks like this:

``` python
    config = {
    apiKey": "apiKey",
    "authDomain": "projectId.firebaseapp.com",
    "databaseURL": "https://databaseName.firebaseio.com",
    "storageBucket": "projectId.appspot.com"
    }
```
  
   Fill it out with the information you gathered earlier and save. 
   
   3. When pyrebase is successfully installed, run the script  'RPy_python/pushReadings.py' on your Raspberry pi. Now your raspberry pi is ready to start speaking with your Firebase.

   4. Test your script. 

      - Open up your Firebase Console and navigate to the Firebase Database. Try pressing the touch sensor and see if the value in your database changes with your touch. If so you're on the right track

      <img src="./Images/lightOn.png "
   alt="download the Google Plist to connect to firebase" width="400"/>

      - Try manually changing the 'light' value in your firebase. Does that turn the LED in your circuit on and off? If so, great! Let's move on to setting up the iOS side of things. 

      <img src="./Images/lightOff.png "
   alt="download the Google Plist to connect to firebase" width="400"/>


    

#### Set up your iPhone!
   1. Open the provided xcode project 'iPhone_Swift/My Sensor Net.workspace'. Inside you want to make sure to set the developer account and create a unique bundle ID as shown in the image below:
   
   <img src="./Images/setupXcode.png"
   alt="get your app ready to compile" width="800"/>
   
   
   2. Next we have to go back to the Firebase console to download the configuration file for our Swift app. 
    - Open up your firebase console
    - Click 'Add an app'
    - Select iOS 
    - Fill in the information below using the Bundle ID you just created

   <img src="./Images/fillInfo.png "
   alt="Ifill in your app info" width="400"/>
   
   
   - Once your app is created, click to download your Google Plist. Drag and drop it into your Xcode project. This will be used to point your swift app to the correct firebase. 

   <img src="./Images/downloadPlist.png "
   alt="download the Google Plist to connect to firebase" width="400"/>
   
   3. From there you should be ready to roll. Build the app and give it a try!


#### Closing thoughts
   If your circuit is set up correctly and you successfully integrated Firebase into both your Swift and Python projects, you should be able to communicate back and forth just by overwriting specific values in your database. Of course, this is a ton more you could do with this if you're interested. 
   
  
    


