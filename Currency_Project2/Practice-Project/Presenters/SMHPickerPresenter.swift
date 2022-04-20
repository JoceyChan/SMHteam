//
//  SMHPickerPresenter.swift
//  Practice-Project
//
//  Created by Jaqueline Sanchez-Macias on 4/16/22.
//

import UIKit

class SMHPickerPresenter {
    
    let currencyManager = SMHCurrencyManager.shared
    var view: SMHPickCurrencyViewController?
    
    weak var mainControllerDelegate: SMHMainPresenter?
    
    func getInitialSelections() -> (Int, Int) {
        let fromCurrencyCode = currencyManager.fromCurrency.code
        let toCurrencyCode = currencyManager.toCurrency.code
        
        let topIndex = getIndexInOrdered(for: fromCurrencyCode, codesList: Currencies.all)
        let bottomIndex = getIndexInOrdered(for: toCurrencyCode, codesList: Currencies.all)
        
        return (topIndex, bottomIndex)
    }
    
    private func getIndexInOrdered(for code: String, codesList: [String]) -> Int {
        let index = codesList.enumerated().filter({code == $0.element}).map { $0.offset }
        return index[0]
    }
    
    func handleConfirmClicked() {
        guard let vc = view else {
            return
        }
        
        let topSelectionCode = Currencies.all[vc.topPickerView.selectedRow(inComponent: 0)]
        let bottomSelectionCode = Currencies.all[vc.bottomPickerView.selectedRow(inComponent: 0)]
        
        if bottomSelectionCode == topSelectionCode {
            self.presentEqualCurrencyErrorAlert()
            return
        }
        
        self.currencyManager.changeFromCurrencyCode(to: topSelectionCode)
        self.currencyManager.changeToCurrencyCode(to: bottomSelectionCode)
        self.currencyManager.updateExchangeRate()
        self.mainControllerDelegate?.resetCurrencies()
        vc.navigationController?.popViewController(animated: true)
    }
    
    func presentEqualCurrencyErrorAlert() {
        let alertController = UIAlertController(title: CurrencyPickerMessages.errorTitle, message: CurrencyPickerMessages.errorMessage, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: CurrencyPickerMessages.buttomTitle, style: .default)
        
        alertController.addAction(dismissAction)
        
        view?.present(alertController, animated: true)
    }
}

