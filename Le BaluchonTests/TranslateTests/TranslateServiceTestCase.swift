//
//  TranslateServiceTestCase.swift
//  Le BaluchonTests
//
//  Created by Jonathan Gaffé on 2020/7/1.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//
@testable import Le_Baluchon
import XCTest

class TranslateServiceTestCase: XCTestCase {
    
    func testOk() {
        
        let translate = TranslationService(httpClient: HTTPClient(httpEngine: HTTPEngine(session: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil))))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        translate.getTranslation(textInput: "Oui", target: "en") { (result: Result<TranslateJSON, NetworkError>) in
            guard case .success(let text) = result else {
                XCTFail("No text")
                return
            }
            
            XCTAssertNotNil(text)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    
    //        let httpEngine = HTTPEngine.init(session: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil))
    //        let translate = TranslationService(httpClient: HTTPClient(httpEngine: httpEngine))
    //
    //        translate.getCurrency(textInput: "Oui", target: "en") { (result: Result<TranslateJSON, NetworkError>) in
    //
    //
    //            guard case .success(let text) = result else {
    //                XCTFail("No text")
    //                return }
    //
    //            XCTAssertNotEqual(text.data.translations[0].translatedText, "Yes")
    //        }
    
    
    func testError() {
        let httpEngine = HTTPEngine.init(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseKO, error: FakeResponseData.error))
        
        let translate = TranslationService(httpClient: HTTPClient(httpEngine: httpEngine))
        
        translate.getTranslation(textInput: "Oui", target: "en") { (result: Result<TranslateJSON, NetworkError>) in
            guard case .failure(let error) = result else { return }
            
            XCTAssertEqual(error, NetworkError.noData)
        }
    }
}
