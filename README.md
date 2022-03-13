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