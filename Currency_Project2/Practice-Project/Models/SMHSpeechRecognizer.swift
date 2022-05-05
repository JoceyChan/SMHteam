//
//  SpeechRecognizer.swift
//  Practice-Project
//
//  Created by Alex Roman on 5/3/22.
//

import Foundation
import AVFoundation
import Speech

protocol SpeechRecognizerTranscriptDelegate {
    func willChangeTranscriptTo(transcript: String)
}


/// A Speech Recognition class that handles the speech recognition engine and microphone recording.
class SMHSpeechRecognizer {
    
    //Boundaries
    enum RecognizerError: Error {
        case nilRecognizer
        case notAuthorizedToRecognize
        case notAuthorizedToRecord
        case recgonizerIsUnavailable
        
        var message: String {
            switch self {
            case .nilRecognizer:
                return "Can't initialize speech recognizer"
            case .notAuthorizedToRecognize:
                return "Not authorized to recognize speech"
            case .notAuthorizedToRecord:
                return "Not authorized to record audio"
            case .recgonizerIsUnavailable:
                return "Recognizer is unavailable, please wait."
            }
        }
    }
    
    //Speech recognizer, and audio vars
    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private let recognizer: SFSpeechRecognizer?
    
    //class delegate used for updating caller of transcipt changes
    var delegate: SpeechRecognizerTranscriptDelegate?
    
    //Running recognizer transcript
    var transcript: String = "" {
        didSet {
            delegate?.willChangeTranscriptTo(transcript: transcript)
        }
    }
    
    //init checks for permisissions
    init(){
        print("starting engine")
        recognizer = SFSpeechRecognizer()
      
        Task(priority: .background) {
            do {
                guard recognizer != nil else {
                    throw RecognizerError.nilRecognizer
                }
                
                guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else {
                    throw RecognizerError.notAuthorizedToRecord
                }
                
                guard await AVAudioSession.sharedInstance().hasPermissionToRecord() else {
                    throw RecognizerError.notAuthorizedToRecord
                }
            } catch {
                speakError(error)
            }
        }
            
    }
    
    deinit{
        reset()
    }
    
    func stopTranscribing() {
        reset()
    }
    //cancels all active recordings
    func reset(){
        task?.cancel()
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        task = nil
    }
    
    //starts transcribing audio from buffer
    func transcribe() {
        //starts transcribing in background
        DispatchQueue(label: "Speech Recognizer Queue", qos: .background).async {
            [ weak self] in
            //checks to ensure thatthe recognizer is available or no nil
            guard let self = self, let recognizer = self.recognizer, recognizer.isAvailable else {
                print(RecognizerError.recgonizerIsUnavailable)
                self?.speakError(RecognizerError.recgonizerIsUnavailable)
                return
            }
          
            // attempts to start speech recognition task
            do {
                let (audioEngine, request) = try Self.prepareEngine()
                self.audioEngine = audioEngine
                self.request = request
                self.task = recognizer.recognitionTask(with: request, resultHandler: self.recognitionHandler(result:error:))
            } catch {
                self.reset()
                print(error)
                self.speakError(error)
            }
        }
        
    }
    
    
    /// Prepares the audio buffer and engine sessions
    /// - Returns: Resturns an active audio engine, and speech recognition buffer
    private static func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        let audioEngine = AVAudioEngine()
        
        let request = SFSpeechAudioBufferRecognitionRequest()
        
        request.shouldReportPartialResults = true
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: AVAudioSession.Mode.measurement, options: AVAudioSession.CategoryOptions.duckOthers)
        
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        try audioSession.setAllowHapticsAndSystemSoundsDuringRecording(true)
        let inputNode = audioEngine.inputNode
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            request.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
        return (audioEngine, request)
    }
    
    
    /// Closure that handles when a recognition task is complete
    /// - Parameters:
    ///   - result: recognition was successful
    ///   - error: recognition failed
    private func recognitionHandler(result: SFSpeechRecognitionResult?, error: Error?){
        let receivedFinalResult = result?.isFinal ?? false
        let receivedError = error != nil
        
        if receivedFinalResult || receivedError {
            audioEngine?.stop()
            audioEngine?.inputNode.removeTap(onBus: 0)
        }
        
        if let result = result {
            speak(with: result.bestTranscription.formattedString)
        }
    }
    
    
    
    /// Takes in a message to update the running transcript
    /// - Parameter messsage: message string
    private func speak(with messsage: String){
        transcript = messsage
        print(transcript)
    }
    
    
    /// Appends the encountered error the running transcript. It is possible for the transcript to contain valid
    ///  words, and errors at the same time - depending on when the error was encountered
    /// - Parameter error: <#error description#>
    private func speakError(_ error: Error){
        var errorMessage = ""
        if let error = error as? RecognizerError {
            errorMessage += error.message
        } else {
            errorMessage += error.localizedDescription
        }
        
        transcript = "<< \(errorMessage) >>"
    }
    
    
}

// implements speech recognizer authorization request
extension SFSpeechRecognizer {
    static func hasAuthorizationToRecognize() async -> Bool {
        await withCheckedContinuation({ continuation in
            requestAuthorization { authStatus in
                continuation.resume(returning: authStatus == .authorized)
            }
        })
    }
}

// implements recording authorization request
extension AVAudioSession {
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation({ continuation in
            requestRecordPermission { isAuthorized in
                continuation.resume(returning: isAuthorized)
            }
        })
    }
}
