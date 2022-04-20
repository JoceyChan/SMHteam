//
//  SMHCurrency.swift
//  Practice-Project
//
//  Created by Jaqueline Sanchez-Macias on 4/16/22.
//

import Foundation

class SMHCurrency {
    
    var symbol = "$"
    var code = Currencies.usd
    var money = SMHMoney()
    
    init(code: String) {
        self.code = code
    }
    
    func getString() -> String {
        return symbol + money.getStringValue()
    }
    
    func getTrimmedString() -> String {
        return symbol + money.getTrimmedStringValue()
    }
    
    func add(char: String) {
        money.add(character: char)
    }
    
    func delete() {
        money.delete()
    }
    
    func getNumeric() -> Double {
        return money.getNumericValue()
    }
    
    func emptyMoney() {
        money.emptyRepresentation()
    }
}

