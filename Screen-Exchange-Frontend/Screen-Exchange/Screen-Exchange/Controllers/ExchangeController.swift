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
   
    private func updatePrimaryAmount(with string: String){
        primaryAmount = Decimal(string: string) ?? primaryAmount
    }
    
    private func updateSecondaryAmount(with string: String){
        secondaryAmount = Decimal(string: string) ?? primaryAmount
    }
    
    private func updateConversions(with userInput: String){
    
        primaryAmount = Decimal(string: userInput)
        primaryCurrencyTextField.text! = userInput
        //calculate conversion and update secondary text
        secondaryAmount = primaryAmount * exchangeRate
        secondaryCurrencyTextField.text! = "\(secondaryAmount!)"
    }
    
    //MARK: Key Pressed
    
    @IBAction func onButtonOneTouch(_ sender: Any) {
        primaryCurrencyText! += "1"
        updateConversions(with: primaryCurrencyText ?? "0.0")
        
    }
    @IBAction func onButtonTwoTouch(_ sender: Any) {
        primaryCurrencyText! += "2"
        updateConversions(with: primaryCurrencyText ?? "0.0")
    }
    
    @IBAction func onButtonThreeTouch(_ sender: Any) {
        primaryCurrencyText! += "3"
        updateConversions(with: primaryCurrencyText ?? "0.0")
    }
    
    @IBAction func onButtonFourTouch(_ sender: Any) {
        primaryCurrencyText! += "4"
        updateConversions(with: primaryCurrencyText ?? "0.0")
    }
    @IBAction func onButtonFiveTouch(_ sender: Any) {
        primaryCurrencyText! += "5"
        updateConversions(with: primaryCurrencyText ?? "0.0")
    }
    @IBAction func onButtonSixTouch(_ sender: Any) {
        primaryCurrencyText! += "6"
        updateConversions(with: primaryCurrencyText ?? "0.0")
    }
    @IBAction func onButtonSevenTouch(_ sender: Any) {
        primaryCurrencyText! += "7"
        updateConversions(with: primaryCurrencyText ?? "0.0")
    }
    @IBAction func onButtonEightTouch(_ sender: Any) {
        primaryCurrencyText! += "8"
        updateConversions(with: primaryCurrencyText ?? "0.0")
    }
    @IBAction func onButtonNineTouch(_ sender: Any) {
        primaryCurrencyText! += "9"
        updateConversions(with: primaryCurrencyText ?? "0.0")
    }
    @IBAction func onButtonPeriodTouch(_ sender: Any) {
        primaryCurrencyText! += "."
        updateConversions(with: primaryCurrencyText ?? "0.0")
    }
    @IBAction func onButtonZeroTouch(_ sender: Any) {
        primaryCurrencyText! += "0"
        updateConversions(with: primaryCurrencyText ?? "0.0")
    }
    @IBAction func onDeleteButtonTouch(_ sender: Any) {
        primaryCurrencyText! = String(primaryCurrencyText!.dropLast())
        updateConversions(with: primaryCurrencyText ?? "0.0")
        
    }
    
}




