//
//  ExchangeService.swift
//  Screen-Exchange
//
//  Created by Alex Roman on 4/16/22.
//

import Foundation

enum Endpoint: String{
    case countries = "/api/v7/countries?"
    case currencies = "/api/v7/currencies?"
    case convert = "/api/v7/convert?"
}

class ExchangeService {
    
    let apiKey = ProcessInfo.processInfo.environment["apiKey"]
    let apiUrl = "https://free.currconv.com"
    
    init(){}
    
    
    /// Uses your API key and the base url to build the API request string for the countries endpoint
    /// - Returns: An HTTP Request String
    func buildCountriesEndpoint() -> String {
        let endpoint = "\(Endpoint.countries.rawValue)apiKey=\(apiKey! )"
        let reqURL = "\(apiUrl)\(endpoint)"
        return reqURL
    }
    
    
    /// Uses your API key and the base url to buil the API request string for the currencies endpoint
    /// - Returns: An HTTP Request String
    func buildCurrenciesEndpoint() -> String {
        let endpoint = "\(Endpoint.currencies.rawValue)apiKey=\(apiKey! )"
        let reqURL = "\(apiUrl)\(endpoint)"
        return reqURL
    }
    
    
    /// Uses your API key and the base url to build the API request string for a currency conversions
    /// - Parameters:
    ///   - baseCurrency: A string that secifies that starting currency, e.g: "USD"
    ///   - secondaryCurrency: A string that specifies the ending currency, e.g: "EUR"
    /// - Returns: An HTTP Request String
    func buildConversionEndpoint(from baseCurrency:String, to secondaryCurrency:String) -> String {
        let endpoint = "\(Endpoint.convert.rawValue)q=\(baseCurrency)_\(secondaryCurrency)&compact=ultra&apiKey=\(apiKey!)"
        let reqURL = "\(apiUrl)\(endpoint)"
        return reqURL
    }
    
    
    
    /// Makes a request to the api, can gets a list of all the currencies, and their associated info.
    /// - Parameter completionFunction: A function that is specified by the caller to handle the data or error response.
    func getAllCurrencies(completionFunction: @escaping ()->Void){
       //TODO: Using the buildCurrenciesEndpoint() function, make an http request to get a response back. Then use the completionFunction to pass that appropriate data to the caller.
    }
    
    
    /// Makes a request to the api, and gets a list of all the countries and what currencies they use.
    /// - Parameter completionFunction: A function that is specified by the caller to handle the data or error response.
    func getAllCountries(completionFunction: @escaping ()->Void){
        //TODO: Using the buildCountriesEndpoint() function, make an http request to get a response back. Then use the completionFunction to pass that appropriate data to the caller.
    }
    
    
    ///  Makes a request to the api to get the exhange rate between two currencies
    /// - Parameters:
    ///   - baseCurrency: the currency that will be the base, e.g: "USD"
    ///   - secondaryCurrency: the currency that is being converted to, eg: "EUR"
    ///   - completionFunction: A function that is specified by the caller to handle the data or error response.
    func convertCurrency(from baseCurrency:String, to secondaryCurrency: String, completionFunction: @escaping ()-> Void){
        //TODO: Using the builConversionEndpoint(string, string) function, make an http request to get a response back. Then use the completionFunction to pass that appropriate data to the caller.
    }
    
}
