//
//  FixerServiceTestCase.swift
//  Le BaluchonTests
//
//  Created by Jonathan Gaffé on 2020/6/14.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//
@testable import Le_Baluchon
import XCTest

final class FixerServiceTestCase: XCTestCase {
    
    // MARK: - GetCurrency Success    
    func testGetCurrencyShouldPostSuccessCallbackIfNoError() {
        let fixer = FixerService(httpClient: HTTPClient(httpEngine: HTTPEngine(session: URLSessionFake(data: FakeResponseData.fixerCorrectData, response: FakeResponseData.responseOK, error: nil))))
        
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        fixer.getCurrency(currency: "USD") { (result: Result<FixerJSON, NetworkError>) in
            guard case .success(let data) = result else {
                XCTFail("testGetCurrencyShouldPostSuccessCallbackIfNoError")
                return
            }
            
            XCTAssertEqual(data.rates["USD"], 1.140281)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Fixer GetCurrency Failed
    
    func testFixer_ShouldPostFailedCallbackIfIncorrectDataAndResponseKO() {
        let fixer = FixerService(httpClient: HTTPClient(httpEngine: HTTPEngine(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseKO, error: nil))))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        fixer.getCurrency(currency: "USD") { (result: Result<FixerJSON, NetworkError>) in
            guard case .failure(let error) = result else {
                XCTFail("testFixer_ShouldPostFailedCallbackIfIncorrectDataAndResponseKO")
                return
            }
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
    }
}
