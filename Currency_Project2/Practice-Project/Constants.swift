//
//  Constants.swift
//  Practice-Project
//
//  Created by Jaqueline Sanchez-Macias on 4/16/22.
//

import Foundation

//keep adding currencies
struct Currencies {
    static let usd = "USD" //USA (DOLLAR)
    static let eur = "EUR" //EUROPE (EURO)
    static let mxn = "MXN" //MEXICAN PESOS
    static let cad = "CAD" //CANADADIAN DOLLAR
    static let jpn = "JPY" //JAPANESE YEN
    static let gbp = "GBP" //BRITISH POUND
    static let brl = "BRL" //BRAZILIAN REAL
    static let btc = "BTC" //BITCOIN
    static let aud = "AUD" //AUSTRALIAN DOLLAR
    static let sek = "SEK" //SWEDIAH KRONA
    static let chf = "CHF" //SWISS FRANC
    static let inr = "INR" //INDIAN RUPEE
    static let nzd = "NZD" //NEW ZEALAND DOLLAR
    static let krw = "KRW" //SOUTH KOREAN WON
    static let cny = "CNY" //CHINESE YUAN
    
    static let all = [usd, eur, mxn, cad, jpn, gbp, brl, btc, aud, sek, chf, inr, nzd, krw, cny]
}

struct Constants {
    static let apiToken = "5b50bcdafba52ceedd96"
    static let mainControllerDeleteKeyTag = 1
    static let deleteKeyTitle = "delete"
    static let changeCurrencyTitle = "Change Currency"
    static let topPickerTag = 1
    static let bottomPickerTag = 2
}

struct CurrencyPickerMessages {
    static let errorTitle = "Duplicate currencies"
    static let errorMessage = "Please make sure currencies are distinct"
    static let buttomTitle = "Ok"
}

