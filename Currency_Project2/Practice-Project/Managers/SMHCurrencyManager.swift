//
//  SMHCurrencyManager.swift
//  Practice-Project
//
//  Created by Jaqueline Sanchez-Macias on 4/16/22.
//

import Foundation

class SMHCurrencyManager {
    
    var fromCurrency = SMHCurrency(code: Currencies.usd)
    var toCurrency = SMHCurrency(code: Currencies.eur)
    var exchangeRate = 0.0
    var baseEndpoint = "https://free.currconv.com/api/v7/"
    
    var mainDelegate: SMHMainPresenter?
    
    static let shared = SMHCurrencyManager()
}

extension SMHCurrencyManager {
    func addNewCharToCurrency(char: String) {
        self.fromCurrency.add(char: char)
        self.updateCurrencyValues()
    }
    
    func deleteCharFromCurrency() {
        self.fromCurrency.delete()
        self.updateCurrencyValues()
    }
    
    func updateCurrencyValues() {
        let fromCurrencyNumeric = self.fromCurrency.getNumeric()
        let toCurrencyEquivalent = fromCurrencyNumeric * self.exchangeRate
        
        self.toCurrency.money.setRepresentationWith(number: toCurrencyEquivalent)
        
        self.mainDelegate?.updateCalculatedRates(fromCurrencyValue: fromCurrency.getString(), toCurrencyValue: toCurrency.getTrimmedString())
    }
}


// MARK: - Picker View Controller Functions
extension SMHCurrencyManager {
    func changeFromCurrencyCode(to code: String) {
        self.fromCurrency.code = code
    }
    
    func changeToCurrencyCode(to code: String) {
        self.toCurrency.code = code
    }
}

extension SMHCurrencyManager {
    func updateExchangeRate() {
        fetchCurrencyExchange()
    }
    
    func fetchCurrencyExchange() {
        let urlString = "\(baseEndpoint)convert?q=\(fromCurrency.code)_\(toCurrency.code)&compact=ultra&apiKey=\(Constants.apiToken)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        // 1, Create a URL
        if let url = URL(string: urlString) {
            // 2. Create a URLSession
            // Like the browser that is able to search
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            // Passing a call of the handle function. Leaving it to the handler to call it
            let task = session.dataTask(with: url) { [self] data, response, error in
                if error != nil {
                    // delegate?.didFailedWithError(error: error!)
                    print("error")
                    return
                }
                
                if let safeData = data {
                    if let exchangeRate = self.parseJSON(safeData) {
                        self.exchangeRate = exchangeRate
                        self.mainDelegate?.didUpdateExchangeRate(fromCurrency: self.fromCurrency, toCurrency: self.toCurrency, exchangeRate: exchangeRate)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        }
    }
    
    
    func parseJSON(_ exchangeData: Data) -> Double? {
        let decoder = JSONDecoder()
        SMHCurrencyResponse.currencyKey?.stringValue = "\(fromCurrency.code)_\(toCurrency.code)"
        
        do {
            let decodedData = try decoder.decode(SMHCurrencyResponse.self, from: exchangeData)
            
            if let rate = decodedData.exchange {
                return rate
            }
            
            return nil
        } catch {
            // delegate?.didFailedWithError(error: error)
            return nil
        }
    }
}

