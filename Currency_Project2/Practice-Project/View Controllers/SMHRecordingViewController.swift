//
//  SMHRecordingViewController.swift
//  Practice-Project
//
//  Created by Alex Roman on 5/3/22.
//

import UIKit
import AVFoundation

/// A protocol that implements a delegate that informs the caller of the transcribed recording that was captured
protocol RecordingCapturedDelegate {
    func recordingCaptured(money: Double)
}

class SMHRecordingViewController: UIViewController, SpeechRecognizerTranscriptDelegate{
    
    // MARK: Outlests
    @IBOutlet weak var recognizedSpeechLabel: UILabel!
    @IBOutlet weak var micButton: UIButton!
    
    
    var speechRecognizer: SMHSpeechRecognizer?
    var audioSessionManager: SMHAudioSessionManager?
    var isRecording: Bool!
    var amount: Double! = 0.0 {
        willSet {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                self.audioSessionManager?.resetTimer()
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
        }
    }
    var amountText: String = ""{
        didSet {
           
           
                self.amount = self.convertToDouble(transcript: self.amountText)
            
        }
    }
    
    //delegate for sending transcript to protocol caller
    var delegate: RecordingCapturedDelegate? = nil

// MARK: viewController life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets delegates
        
        speechRecognizer?.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //starts transcibing audio as soon as view appears
        speechRecognizer?.reset()
        speechRecognizer?.transcribe()
        isRecording = true
        startRecordingAnimation()
        audioSessionManager = SMHAudioSessionManager(timerTarget: self, timerSelector: #selector(endRecordingCapture))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //stops transcribing audio when view is dismissed
        speechRecognizer?.reset()
        isRecording = false
        delegate?.recordingCaptured(money: amount)
    }
}

// MARK: Obj Func
extension SMHRecordingViewController {
    @objc func endRecordingCapture(){
        speechRecognizer?.reset()
        self.dismiss(animated: true)
    }
}


// MARK: Actions
extension SMHRecordingViewController {
    @IBAction func exitClicked(_ sender: Any) {
        //send transcribed audio back to delegated
        
        self.dismiss(animated: true)
    }
    
    
    /// Detects when a shake gesture occurs, and resets the running amount and speech recognizers
    /// - Parameters:
    ///   - motion: a shake motion
    ///   - event: an event
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            amount = 0.0
            amountText = ""
            recognizedSpeechLabel.text = amountText
            speechRecognizer?.reset()
            speechRecognizer?.transcribe()
            
        }
    }
    
}


// MARK: delegates
extension SMHRecordingViewController {
    func willChangeTranscriptTo(transcript: String) {
        amountText = transcript
        recognizedSpeechLabel.text = amountText
    }

}


// MARK: Transcript quantities verifications
extension SMHRecordingViewController {
    
    /// Verifies that a string only valid currency characters. Does not account for currency symbol
    /// - Parameter transcript: A string from a recognizer transript
    /// - Returns: The string as a double
    func convertToDouble(transcript: String) -> Double{
        guard onlyContainsNumbers(string: transcript) else {
            return 0.0
        }
        
        return Double(transcript) ?? 0.0
    }
    
    
    /// Determines whether a string contains numbers and a periond
    /// - Parameter string: Any string
    /// - Returns: boolean
    func onlyContainsNumbers(string: String) -> Bool{
        for char in string {
            if ((char.asciiValue! < 48) ){
                if( char.asciiValue != 46){
                    return false
                }
            }
            
            if (char.asciiValue! > 57){
                return false
            }
            
        
        }
        return true
    }
}

// MARK: Animations
extension SMHRecordingViewController {
    func startRecordingAnimation(){
        let pulse = PulseAnimation(numberOfPulses: Float.infinity, radius: 200, position: micButton.center)
        let pulse2 = PulseAnimation(numberOfPulses: Float.infinity, radius: 190, position: micButton.center)
        pulse2.animationDuration = 1.5
        pulse.animationDuration = 1.0
        pulse.backgroundColor = micButton.tintColor.cgColor
        pulse2.backgroundColor = micButton.tintColor.cgColor
        self.view.layer.insertSublayer(pulse, below: self.view.layer)
        self.view.layer.insertSublayer(pulse2, below: self.view.layer)
    }
}
