//
//  Int+Extensions.swift
//  Screen-Exchange
//
//  Created by Alex Roman on 4/15/22.
//

import Foundation

extension String {
    func toCurrency() -> String {
        if let value = Decimal(string: self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
            if let str = formatter.string(from: value as NSNumber){
                return str
            }
        }
        
        return self
    }
}

