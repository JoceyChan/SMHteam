
//  SMHCurrencyResponse.swift
//  Practice-Project
//
//  Created by Jaqueline Sanchez-Macias on 4/16/22.
//

import Foundation

struct SMHCurrencyResponse: Decodable {
    
    struct CurrencyCodingKey: CodingKey {
        var intValue: Int? {
            return nil
        }
        
        init?(intValue: Int) {
            return nil
        }
        
        var stringValue: String
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
    }
    
    let exchange: Double?
    
    // need to setup to read input
    static var currencyKey = CurrencyCodingKey(stringValue: "USD_CNY") 
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CurrencyCodingKey.self)
        self.exchange = try container.decodeIfPresent(Double.self, forKey: SMHCurrencyResponse.currencyKey!)
    }
}

