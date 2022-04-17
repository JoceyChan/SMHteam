//
//  SpeechServiceTests.swift
//  Screen-ExchangeTests
//
//  Created by Alex Roman on 4/8/22.
//

import XCTest
@testable import Screen_Exchange

class SpeechServiceTests: XCTestCase {
    var service: SpeechService!
    
    override func setUp() {
        super.setUp()
        service = SpeechService()
    }
    
    override func tearDown() {
        service = nil
        super.tearDown()
    }
    
    func testSpeakWithText() async throws{
        let text = "hello world"
        XCTAssertNoThrow(try! service.speak(text: text, in: Language.englishUS, with: Gender.neutral){
            json in
            print(json)
        }, "Expected no throw")
    }
    
    func testSpeakResponse() async throws {
        let text = "hello world"
        try! service.speak(text: text, in: Language.englishUS, with: Gender.neutral, completion: { json in
            XCTAssertNotNil(json)
        })
    }
    
    

}
