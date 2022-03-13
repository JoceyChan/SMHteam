# SMHteam

To run backend:
1. install node.js 
2. cd into screen-exchange-backend folder
3. run "npm install"
4. create a ".env" file
5. in the ".env" file add the following
    PORT = 8080
    GOOGLE_APPLICATION_CREDENTIALS = ""
6. since the google text to speech requires an API key to authenticate, contact @Alex to 
    receive a key. Alternatively you may create your own google cloud project with text to speech
    and use the api key from that
7. you should be good to run the backend server. just run "npm start" 


 <br/> API Reference: 
 <br/> Base URL: http://localhost:{port}/api

Endpoint:
<br/> /text-to-speech

The endpoint takes in a text string from the request body, and passes it to the Google 
<br/> text to speech API. It then returns a json response that contains the audio, and audio type, and audio data. <br/> To use the audio it will need to be decoded from base64 to MP3 client side.
Req: 
 <br/> {
    <br />    "text": "your text here"
    <br/>    "language: "en-US"
    <br/>      "gender": "NEUTRAL"
 <br/> }

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