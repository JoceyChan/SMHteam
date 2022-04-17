//
//  Int+Extensions.swift
//  Screen-Exchange
//
//  Created by Alex Roman on 4/15/22.
//

import Foundation

extension Float {
    private static var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    
    
    internal var currencyRepresentation: String {
        return Float.currencyFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
