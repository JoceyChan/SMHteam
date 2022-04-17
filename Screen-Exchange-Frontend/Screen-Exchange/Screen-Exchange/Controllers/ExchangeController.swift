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
    @IBOutlet weak var secondaryCurrencyLabel: UILabel!
    @IBOutlet weak var secondaryCurrencyTextField: UITextField!
    
    
  
    
    var primaryAmount: Float!
    var secondaryAmount: Float!
    
    var primaryCurrencyType: String!
    var secondaryCurrencyType: String!
    
    var primaryCurrencyText: String? {
        didSet {
            print(self.primaryAmount.currencyRepresentation)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                UIAccessibility.post(notification: .announcement, argument: "\(String(describing: self.primaryAmount?.currencyRepresentation) ) \(self.primaryCurrencyType!)")
            }
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        primaryAmount = 0.0
        secondaryAmount = 0.0
        
        primaryCurrencyType = "USD"
        secondaryCurrencyType = "CAD"
        
        primaryCurrencyText = ""
        
      
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
   
    private func updatePrimaryAmount(with string: String){
        primaryAmount = Float(string) ?? primaryAmount
    }
    
    private func updateSecondaryAmount(with string: String){
        secondaryAmount = Float(string) ?? primaryAmount
    }
    
    private func updateConversions(){
        
    }
    
    //MARK: Key Pressed
    
    @IBAction func onButtonOneTouch(_ sender: Any) {
        primaryCurrencyText! += "1"
        primaryAmount = Float(primaryCurrencyText!)
        primaryCurrencyTextField.text! = primaryAmount.currencyRepresentation
        
    }
    @IBAction func onButtonTwoTouch(_ sender: Any) {
        primaryCurrencyText! += "2"
        primaryAmount = Float(primaryCurrencyText!)
        primaryCurrencyTextField.text! = primaryAmount.currencyRepresentation
    }
    
    @IBAction func onButtonThreeTouch(_ sender: Any) {
        primaryCurrencyText! += "3"
        primaryAmount = Float(primaryCurrencyText!)
        primaryCurrencyTextField.text! = primaryAmount.currencyRepresentation
    }
    
    @IBAction func onButtonFourTouch(_ sender: Any) {
        primaryCurrencyText! += "4"
        primaryAmount = Float(primaryCurrencyText!)
        primaryCurrencyTextField.text! = primaryAmount.currencyRepresentation
    }
    @IBAction func onButtonFiveTouch(_ sender: Any) {
        primaryCurrencyText! += "5"
        primaryAmount = Float(primaryCurrencyText!)
        primaryCurrencyTextField.text! = primaryAmount.currencyRepresentation
    }
    @IBAction func onButtonSixTouch(_ sender: Any) {
        primaryCurrencyText! += "6"
        primaryCurrencyTextField.text! = primaryAmount.currencyRepresentation
    }
    @IBAction func onButtonSevenTouch(_ sender: Any) {
        primaryCurrencyText! += "7"
        primaryAmount = Float(primaryCurrencyText!)
        primaryCurrencyTextField.text! = primaryAmount.currencyRepresentation
    }
    @IBAction func onButtonEightTouch(_ sender: Any) {
        primaryCurrencyText! += "8"
        primaryAmount = Float(primaryCurrencyText!)
        primaryCurrencyTextField.text! = primaryAmount.currencyRepresentation
    }
    @IBAction func onButtonNineTouch(_ sender: Any) {
        primaryCurrencyText! += "9"
        primaryAmount = Float(primaryCurrencyText!)
        primaryCurrencyTextField.text! = primaryAmount.currencyRepresentation
    }
    @IBAction func onButtonPeriodTouch(_ sender: Any) {
        primaryCurrencyText! += "."
        primaryAmount = Float(primaryCurrencyText!)
        primaryCurrencyTextField.text! = primaryAmount.currencyRepresentation
    }
    @IBAction func onButtonZeroTouch(_ sender: Any) {
        primaryCurrencyText! += "0"
        primaryAmount = Float(primaryCurrencyText!)
        primaryCurrencyTextField.text! = primaryAmount.currencyRepresentation
    }
    @IBAction func onDeleteButtonTouch(_ sender: Any) {
        primaryCurrencyText! = String(primaryCurrencyText!.dropLast())
        primaryAmount = Float(primaryCurrencyText!)
        primaryCurrencyTextField.text! = primaryAmount.currencyRepresentation
        
    }
    
}




