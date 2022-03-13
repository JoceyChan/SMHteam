import 'dotenv/config';
import express from 'express';
import bodyParser from 'body-parser';
import textToSpeech from '@google-cloud/text-to-speech';
import fs from 'fs';
import util from 'util';



//create google text to speech client
const client = new textToSpeech.TextToSpeechClient();

//start express server
const app = express();

//setup parser for json body requests
app.use(bodyParser.json());


/**
 *  The function return a base64 encoded audio file
 * @param {string} text 
 * @returns {bytes} audio
 */
async function getAudioByteStream(text) {
    // Construct the request
    const request = {
        input: {text: text},
        // Select the language and SSML Voice
        voice: {languageCode: 'en-US', ssmlGender: 'NEUTRAL'},

        // Select the type of audio encoding
        audioConfig: {audioEncoding: 'MP3'},
    };

    // Performs the Text-to-Speech request
    return await client.synthesizeSpeech(request);
}


/**
 * The function return a base64 encoded audio file to client
 * @param {string} text
 * @return {json} audio
 */
app.get("/api/text-to-speech", (req, res) => {
    const text = req.body.text;
    console.log(text);

    getAudioByteStream(text).then(audio => {
        res.json({ audio });
        res.status(200);
        res.send();
    }).catch(err => {
        console.error('ERROR:', err);
        res.status(500).send(err);
    });
    
});

app.listen(process.env.PORT, () => {
  console.log("Server is running on port " + process.env.PORT);
});

