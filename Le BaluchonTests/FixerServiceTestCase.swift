//
//  FixerServiceTestCase.swift
//  Le BaluchonTests
//
//  Created by Jonathan Gaffé on 2020/6/14.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//
@testable import Le_Baluchon
import XCTest

class FixerServiceTestCase: XCTestCase {
 
    let url = URL(string: "http://data.fixer.io/api/latest?")!
    let parameters = [("access_key", "173e725be7b0231e46c4f70d08b278eb"), ("symbols", "USD")]

    func testA() {
        let fixer = FixerService(httpClient: HTTPClient(httpEngine: HTTPEngine(session: URLSessionFake(data: FakeResponseData.fixerCorrectData, response: FakeResponseData.responseOK, error: nil))))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        fixer.getCurrency(currency: "USD") { (result: Result<FixerJSON, NetworkError>) in
             guard case .success(let data) = result else { return }
                       
                       XCTAssertEqual(data.rates["USD"], 1.140281)
                       expectation.fulfill()
        }
    
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testB() {
    let fixer = FixerService(httpClient: HTTPClient(httpEngine: HTTPEngine(session: URLSessionFake(data: FakeResponseData.fixerCorrectData, response: FakeResponseData.responseOK, error: nil))))
    
    let expectation = XCTestExpectation(description: "Wait for queue change")
    
    fixer.getCurrency(currency: "USD") { (result: Result<FixerJSON, NetworkError>) in
         guard case .failure(let error) = result else { return }
                   
                   XCTAssertEqual(data.rates["USD"], 1.140281)
                   expectation.fulfill()
    }
    
    

}
