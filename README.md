# SMHteam

### Getting Started with the Front-End
1. Download and install [xcode](https://developer.apple.com/xcode/)
2. CD into this projects root directory
3. Go int `./Screen-Exchange-Frontend/Screen-Exchange`
4. Open the `./Screen-Exchange.xcworkspace` file
5. Your ready to start coding
6. To run the app, at the top of xcode choose a simulator and then click the play button

#### New to xcode and swift?

##### Storyboards

The storyboards file is where you create the UI using a graphical editor.
To start adding screens, labels, image press `CMD+Shift+L ` to open the UI library and drag a UI Elements

The right pane is the editor where you can customize the elements

Note: Since storyboards result in hard to solve merge conflicts only one person should be working on a storyboard at a time. Multiple storyboard files will be used to avoid this issue

#### Controllers
You will notice there will be files named something like `viewController.swift`. These files implement the logic to a screen or a.k.a a `view controller`. So every screen should have it's own controller file.

#### Swift

Swift is object oriented and strongly typed - but very friendly and easy to pick up. If you're unsure how to implement something there's many tutorials.


## Getting Started
To run backend:
1. install [node.js](https://nodejs.org/en/) 
2. cd into screen-exchange-backend folder
3. run `npm install`
4. create a `.env` file at the root of the backend.
5. Add the following lines
   1. `Port=8080`
   2. `GOOGLE_APPLICATION_CREDENTIALS="screen-exchange-344003-145eed24a7b6.json"`
6. you should be good to run the backend server. just run "npm start"
7. To access the server via an http request 


 <br/> API Reference: 
 <br/> Base URL: http://localhost:{port}/api

Endpoint:
<br/> /text-to-speech

The endpoint takes in a text string from the request body, and passes it to the Google 
<br/> text to speech API. It then returns a json response that contains the audio, and audio type, and audio data. <br/> To use the audio it will need to be decoded from base64 to MP3 client side.

 ### Example cURL Request

 curl --location --request GET 'http://localhost:8080/api/text-to-speech' \
--header 'Content-Type: application/json' \
--data-raw '{
    "text": "Hello Sreeda, Steven, Jaqi, and Jocelyn",
    "language": "en-US", 
    "gender" : "Neutral"
}'

### Example API Response
`
 <br/> Response
  <br/> {
      <br/>    "audio": [
         <br/>     {
             <br/>        "audioContent":  
             <br/>        {
                <br/>            "type": "Buffer",
                 <br/>           "data": [],
            <br/>        }
         <br/>    }
 <br/>}
`
