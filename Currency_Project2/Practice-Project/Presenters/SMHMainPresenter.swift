//
//  SMHMainPresenter.swift
//  Practice-Project
//
//  Created by Jaqueline Sanchez-Macias on 4/16/22.
//

import UIKit

class SMHMainPresenter {
    
    let currencyManager = SMHCurrencyManager.shared
    var view: SMHMainViewController?
    
    init() {
        currencyManager.mainDelegate = self
    }
    
    func updateExchangeRate() {
        currencyManager.updateExchangeRate()
    }
    
    func updateCalculatedRates(fromCurrencyValue: String, toCurrencyValue: String) {
        guard let vc = view else {
            return
        }
        
        vc.updateCurrencyEntries(fromCurrency: fromCurrencyValue, toCurrency: toCurrencyValue)
    }
    
    func didUpdateExchangeRate(fromCurrency: SMHCurrency, toCurrency: SMHCurrency, exchangeRate: Double) {
        guard let vc = view else {
            return
        }
        
        let rate = String(format: "%.02f", exchangeRate)
        
        vc.updatedExchangeRate(fromCode: fromCurrency.code, toCode: toCurrency.code, rate: rate)
    }
    
    func handleButtonEvent(title: String) {
        let number = Int(title) ?? nil
        
        if title == "." || number != nil {
            currencyManager.addNewCharToCurrency(char: title)
        } else if title == Constants.deleteKeyTitle {
            currencyManager.deleteCharFromCurrency()
        } else if title == Constants.changeCurrencyTitle {
            self.routeToPickerView()
        } else {
            // handle speak button
        }
    }
    
    func routeToPickerView() {
        guard let vc = view else {
            return
        }
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let pickerView = mainStoryboard.instantiateViewController(withIdentifier: "pickerViewController") as? SMHPickCurrencyViewController {
            pickerView.presenter.mainControllerDelegate = self
            vc.navigationController?.pushViewController(pickerView, animated: true)
        }
    }
    
    func resetCurrencies() {
        guard let vc = view else {
            return
        }
        
        currencyManager.fromCurrency.emptyMoney()
        currencyManager.toCurrency.money.setRepresentationWith(number: 0.0)
        
        let fromCurrencyString = currencyManager.fromCurrency.money.getStringValue()
        let toCurrencyString = currencyManager.toCurrency.money.getTrimmedStringValue()
        
        vc.updateCurrencyEntries(fromCurrency: fromCurrencyString, toCurrency: toCurrencyString)
    }
    
    func setFromCurrency(amount: Double){
        guard let vc = view else {
            return
        }
        
        currencyManager.fromCurrency.money.setRepresentationWith(number: amount)
        let fromCurrencyString = currencyManager.fromCurrency.money.getStringValue()
       
        currencyManager.updateCurrencyValues()
        let toCurrencyString = currencyManager.toCurrency.money.getTrimmedStringValue()
        vc.updateCurrencyEntries(fromCurrency: fromCurrencyString, toCurrency: toCurrencyString)
        
    }
}

