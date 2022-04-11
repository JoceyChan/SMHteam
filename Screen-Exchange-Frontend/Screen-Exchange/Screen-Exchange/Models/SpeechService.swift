//
//  SpeechService.swift
//  Screen-Exchange
//
//  Created by Alex Roman on 4/8/22.
//

import Foundation
import AVFoundation
import UIKit

enum Language: String {
    case englishUS = "en-US"
    case englishUK = "en-GB"
    case spanishUS = "es-US"
}

enum Gender: String {
    case neutral = "Neutral"
    case male = "Male"
    case female = "Female"
}

enum SpeechServiceError: Error {
    case serviceInUse
    case invalidRequest
    case httpError(message: String)
    case unexpected(message: String)
}

/**
    
 */
class SpeechService  {
    
     var serviceUrl =  "http://localhost:8080/api/text-to-speech"
     var player: AVAudioPlayer?
     var isSynthesizing: Bool!
    
    init() {
        isSynthesizing = false
        
    }
    
    
    public func speak(text: String,in language: Language, with voiceGender: Gender, completion: @escaping ([String:Any])->Void) throws {
        
        guard !self.isSynthesizing else {
            throw SpeechServiceError.serviceInUse
            
        }
        
        self.isSynthesizing = true
        
        let request = try? formRequest(text: text, language: language.rawValue, gender: voiceGender.rawValue)
        
        if let req = request {
            let session = URLSession.shared
            let task = session.dataTask(with: req) { data, response, err in
                if let err = err {
                    //handle error
                    print(err.localizedDescription)
                } else if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any?]
                    {
//                        print(json)
                        completion(json)
                        
                    }
                } else {
                    print("unexpected error")
                }
            }
            
            task.resume()
        }

    }
    
   
    
     private func formRequest(text: String, language: String, gender: String) throws ->URLRequest {
         guard let reqUrl = URL(string: serviceUrl) else { throw SpeechServiceError.invalidRequest }
       
        
        var request = URLRequest(url: reqUrl)
        
        let body = [
            "text": "Hello",
            "language": "en-US",
            "gender" : "Neutral"
        ]
        let bodyData = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        request.httpMethod = "POST"
        request.httpBody = bodyData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         
         return request
    }
    
    
 //   service = SpeechService()
   
    
//        try! service.speak(text: "String", in: Language.englishUS, with: Gender.neutral) { (json) in
//            let array = json["audio"]! as! NSArray
//            let object = array[0] as! NSDictionary
//             let audioConent = object["audioContent"]! as! NSDictionary
//            let audioData = audioConent["data"] as! NSArray
//            print(audioConent)
//            print(audioData)
//            var string = ""
//            for num in audioData{
//                string = string + "\(num)"
//            }
//
//            print(string)
//            let data = Data(base64Encoded: string, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
//            if audioData != nil {
//                if audioData != nil {
//
//                }
//            }
////            print()
//
//        }
    

    
}
