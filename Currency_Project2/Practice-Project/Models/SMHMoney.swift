//
//  SMHMoney.swift
//  Practice-Project
//
//  Created by Jaqueline Sanchez-Macias on 4/16/22.
//

import Foundation


class SMHMoney {
    
    private var representation = ""
    private var containsPeriod = -1
    
    func add(character: String) {
        
        if containsPeriod == 0 && representation.count == 1 && character == "." {
            return
        }
        
        if character == "0" && representation.count == 0 {
            return
        }
        
        if character == "." {
            containsPeriod = representation.count
        }
        
        representation += character
    }
    
    func delete() {
        guard !representation.isEmpty else {
            return
        }
        
        if self.getLastCharacter() == "." {
            containsPeriod = -1
        }
        
        representation = String(representation.prefix(representation.count - 1))
    }
    
    func getNumericValue() -> Double {
        if representation.isEmpty {
            return 0.0
        }
        
        if self.getLastCharacter() == "." && representation.count == 1 {
            return 0.0
        }
        
        if let number = Double(representation) {
            return number
        }
        
        return 0.0
    }
    
    func getStringValue() -> String {
        if representation.isEmpty {
            return "0"
        }
        
        if representation.count == 1 && self.getLastCharacter() == "." {
            return "0."
        }
        
        if containsPeriod == 0 {
            return "0" + representation
        }
        
        return representation
    }
    
    func getTrimmedStringValue() -> String {
        guard let number = Double(representation) else {
            return "0"
        }
        
        let trimmedString = String(format: "%.02f", number)
        return trimmedString
    }
    
    func setRepresentationWith(number: Double) {
        self.representation = String(number)
    }
    
    func emptyRepresentation() {
        self.representation = ""
    }
    
    private func getSubstring(to: Int) -> String {
        let index = representation.index(representation.startIndex, offsetBy: to)
        return String(representation.prefix(upTo: index))
    }
    
    private func getLastCharacter() -> String {
        if representation.isEmpty {
            return ""
        }
        
        let index = representation.index(representation.startIndex, offsetBy: representation.count - 1)
        return String(representation[index])
    }
}


