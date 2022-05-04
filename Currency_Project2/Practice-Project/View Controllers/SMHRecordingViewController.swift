//
//  SMHRecordingViewController.swift
//  Practice-Project
//
//  Created by Alex Roman on 5/3/22.
//

import UIKit

class SMHRecordingViewController: UIViewController, SpeechRecognizerTranscriptDelegate{
    @IBOutlet weak var recognizedSpeechLabel: UILabel!
    
    func willChangeTranscriptTo(transcript: String) {
        recognizedSpeechLabel.text = transcript
    }
    
    var speechRecognizer: SMHSpeechRecognizer?
    var isRecording: Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        speechRecognizer?.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        speechRecognizer?.reset()
        speechRecognizer?.transcribe()
        isRecording = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        speechRecognizer?.reset()
        isRecording = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
