//
//  ViewController.swift
//  Screen-Exchange
//
//  Created by Alex Roman on 4/8/22.
//

import UIKit
import AVFoundation
import AVKit
import Money

class ExchangeController: UIViewController {
    @IBOutlet weak var PrimaryCurrencyView: UIView!
    @IBOutlet weak var SecondaryCurrencyView: UIView!
    @IBOutlet weak var exchangeRateLabel: UILabel!
    @IBOutlet weak var primaryCurrencyLabel: UILabel!
    @IBOutlet weak var primaryCurrencyTextField: UITextField!
    @IBOutlet weak var secondaryCurrencyLabel: UILabel!
    @IBOutlet weak var secondaryCurrencyTextField: UITextField!
    
    
  
    
    var primaryAmount: Decimal!
    var secondaryAmount: Decimal!
    var primaryCurrencyType: String!
    var secondaryCurrencyType: String!
    var exchangeRate: Decimal!
    
    var speechRecognizer: SpeechRecognizer!
    var isRecording: Bool! {
        didSet{
            if(isRecording){
                
            }
        }
    }
    
    var primaryCurrencyText: String? {
        didSet {
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                guard !(self.primaryCurrencyText?.isEmpty ?? "".isEmpty) else {
                    UIAccessibility.post(notification: .announcement, argument: "\(self.primaryCurrencyType!) to \(self.secondaryCurrencyType!)" )
                    return
                }
                UIAccessibility.post(notification: .announcement, argument: "\(String(describing: self.primaryCurrencyText!.toCurrency())) \(self.primaryCurrencyType!) is \(String(describing: self.secondaryCurrencyTextField.text?.toCurrency() ?? "")) \(self.secondaryCurrencyType!)")
            }
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        speechRecognizer = SpeechRecognizer()
        primaryAmount = 0.0
        secondaryAmount = 0.0
        exchangeRate = 1.26
        
        primaryCurrencyType = "USD"
        secondaryCurrencyType = "CAD"
        
        
        primaryCurrencyText = ""
        
        exchangeRateLabel.text = "\(primaryCurrencyType!) to \(secondaryCurrencyType!)"
      
        primaryCurrencyLabel.text = "\(String(describing: primaryCurrencyType!))"
        secondaryCurrencyLabel.text = "\(String(describing: secondaryCurrencyType!))"
     
    
        // Do any additional setup after loading the view.
        
    }
    

    @IBAction func onPrimaryCurrencyChange(_ sender: Any) {
        print("value changed")
        speak(with: primaryCurrencyTextField.text ?? "")
    }

    
    
    
    private func speak(with text:String){
        let synth = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: text ?? "")
        let voice = AVSpeechSynthesisVoice(language: "en-GB")
        let gender = AVSpeechSynthesisVoice(identifier: AVSpeechSynthesisVoiceIdentifierAlex)
        
        synth.speak(utterance)
    }
   
    private func setUI(){
        
        SecondaryCurrencyView.layer.cornerRadius = 10
        PrimaryCurrencyView.layer.cornerRadius = 10
    }
    private func updatePrimaryAmount(with string: String){
        primaryAmount = Decimal(string: string) ?? primaryAmount
    }
    
    private func updateSecondaryAmount(with string: String){
        secondaryAmount = Decimal(string: string) ?? primaryAmount
    }
    
    private func updateConversions(with userInput: String){
        if userInput.isEmpty {
            primaryAmount = 0.0
        } else {
            primaryAmount = Decimal(string: userInput)
        }
        primaryCurrencyTextField.text! = userInput
        //calculate conversion and update secondary text
        secondaryAmount = primaryAmount * exchangeRate
        secondaryCurrencyTextField.text! = "\(secondaryAmount!)".toCurrency()
    }
    
    //MARK: Key Pressed
    @IBAction func onSpeakIn(_ sender: Any) {
        speechRecognizer.reset()
        speechRecognizer.transcribe()
        
    
}




