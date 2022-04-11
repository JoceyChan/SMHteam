//
//  ViewController.swift
//  Screen-Exchange
//
//  Created by Alex Roman on 4/8/22.
//

import UIKit
import AVFoundation
import AVKit

class ExchangeController: UIViewController {
    @IBOutlet weak var exchangeRateLabel: UILabel!
    @IBOutlet weak var primaryCurrencyLabel: UILabel!
    @IBOutlet weak var primaryCurrencyTextField: UITextField!
    @IBOutlet weak var secondaryCurrencyLabl: UILabel!
    var primaryAmount: Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        primaryAmount = 0.0
        primaryCurrencyTextField.text = ""
    
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func onPrimaryCurrencyChange(_ sender: Any) {
        SynthesizerService.speak(text: primaryCurrencyTextField.text ?? "")
    }
    
    @IBAction func updatePrimaryCurrency(_ sender: Any) {
        primaryAmount = primaryAmount + 1
        primaryCurrencyTextField.text = "$\(primaryAmount!) CAD"
        
        speak(with: primaryCurrencyTextField.text ?? "")
        
    }
    
    
    func speak(with text:String){
        let synth = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: text ?? "")
        let voice = AVSpeechSynthesisVoice(language: "en-GB")
        let gender = AVSpeechSynthesisVoice(identifier: AVSpeechSynthesisVoiceIdentifierAlex)
        
        synth.speak(utterance)
    }
    
    

}

