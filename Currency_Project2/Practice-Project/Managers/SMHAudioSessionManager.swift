//
//  SMHAudioSessionManager.swift
//  Practice-Project
//
//  Created by Alex Roman on 5/5/22.
//

import Foundation
import AVFoundation

class SMHAudioSessionManager {
    var timer: Timer?
    var timerTarget: Any
    var timerSelector: Selector!
    
    
    init(timerTarget: Any, timerSelector: Selector){
        self.timerTarget = timerTarget
        self.timerSelector = timerSelector
        createTimer(currTarget: self.timerTarget, currSelector: self.timerSelector)
        
    }
    
    func createTimer(currTarget: Any, currSelector: Selector) {
        timer = Timer.scheduledTimer(timeInterval: 10.0, target: currTarget, selector: currSelector, userInfo: nil, repeats: true)
        
       
    }
    
    func resetTimer(){
        timer?.invalidate()
        createTimer(currTarget: self.timerTarget, currSelector: self.timerSelector)
    }
}
