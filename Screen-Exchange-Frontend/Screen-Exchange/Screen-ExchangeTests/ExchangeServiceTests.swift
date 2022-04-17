//
//  ExchangeServiceTests.swift
//  Screen-ExchangeTests
//
//  Created by Alex Roman on 4/16/22.
//

import XCTest
@testable import Screen_Exchange

class ExchangeServiceTests: XCTestCase {
    var service: ExchangeService!
    
    override func setUp() {
        super.setUp()
        service = ExchangeService()
    }
    
    override func tearDown() {
        service = nil
        super.tearDown()
    }

    func testExchangeBuildCountriesUrl(){
        XCTAssertTrue(service.buildCountriesEndpoint() == "https://free.currconv.com/api/v7/countries?apiKey=0f3cf06e04c2d1a6fc41", service.buildCountriesEndpoint())
    }
    func testExchangeBuildCurrenciesUrl(){
        XCTAssertTrue(service.buildCurrenciesEndpoint() == "https://free.currconv.com/api/v7/currencies?apiKey=0f3cf06e04c2d1a6fc41", service.buildCurrenciesEndpoint())
    }
    
    func testExchangeBuildConversionUrl(){
        XCTAssertTrue(service.buildConversionEndpoint(from:"USD", to: "EUR") == "https://free.currconv.com/api/v7/convert?q=USD_EUR&compact=ultra&apiKey=0f3cf06e04c2d1a6fc41", service.buildConversionEndpoint(from: "USD", to: "EUR"))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
