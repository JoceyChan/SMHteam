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
    case femal = "Female"
}

enum SpeechServiceError: Error {
    case serviceInUse
    case unexpected(message: String)
}

class SpeechService: AVAudioPlayer {
    
    private var serviceURl: String!
    private var player: AVAudioPlayer?
    private var isSynthesizing: Bool!
    
    override init() {
        super.init()
        self.serviceURl = "http://localhost:8080/api/text-to-speech"
        self.player = AVAudioPlayer()
        self.isSynthesizing = false
    }
    
    
    public func speak(text: String,in language: Language, with voiceGender: Gender, completion: @escaping () -> Void) throws {
        
        guard !self.isSynthesizing else {
            throw SpeechServiceError.serviceInUse
            return
        }
        
        self.isSynthesizing = true
    }
    
    private func getTextToSpeech(text: String, language: String, gender: String){
        DATA
    }
    
}
