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
    // Tester httpengine
    
    let httpEngine = HTTPEngine()
    let httpClient = HTTPClient()
    let url = URL(string: "http://data.fixer.io/api/latest?")!
    
    
    
    // MARK: - Error
    func testGetCurrencyShouldPostFailedCallbackError() {
        let fixerEn = HTTPEngine(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
        
       
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        
        fixerEn.request(baseUrl: url, parameters:  [("access_key", "173e725be7b0231e46c4f70d08b278eb"), ("symbols", "USD")]) {  (result: Result<FixerJSON, NetworkError>) in
                   guard case .failure(let error) = result else {
                       XCTFail("testFixerShouldPostFailedCallbackError")
                       return
                   }
        
        
        //        let fixer = HTTPClient(httpEngine: HTTPEngine(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error)))
        //
        //        fixer.request(baseURL: url, parameters: [("access_key", "173e725be7b0231e46c4f70d08b278eb"), ("symbols", "USD")]) { (result: Result<FixerJSON, NetworkError>) in
        //            guard case .failure(let error) = result else {
        //                XCTFail("testFixerShouldPostFailedCallbackError")
        //                return
        //            }
        
        XCTAssertNotNil(error)
        
        // Then
        expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 0.01)
}

// MARK: - No data
func testGetCurrencyShouldPostFailedCallbackIfNodData() {
    // Given
    let fixer = HTTPClient(httpEngine: HTTPEngine(session: URLSessionFake(data: FakeResponseData.incorrectData, response: nil, error: FakeResponseData.error)))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    
    fixer.request(baseURL: url, parameters: [("access_key", "173e725be7b0231e46c4f70d08b278eb"), ("symbols", "USD")]) { (result: Result<FixerJSON, NetworkError>) in
        guard case .failure(let error) = result else {
            XCTFail("testGetCurrencyShouldPostFailedCallbackIfNodData Fail")
            return
        }
        
        XCTAssertNotNil(error)
        expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
}

// MARK: - Incorrect response
func testGetCurrencyShouldPostFailedCallbackIfIncorrectResponse() {
    // Given
    let fixer = HTTPClient(httpEngine: HTTPEngine(session: URLSessionFake(data: FakeResponseData.fixerCorrectData, response: FakeResponseData.responseKO, error: nil)))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    
    fixer.request(baseURL: url, parameters: [("access_key", "173e725be7b0231e46c4f70d08b278eb"), ("symbols", "USD")]) { (result: Result<FixerJSON, NetworkError>) in
        guard case .failure(let error) = result else {
            XCTFail("testGetCurrencyShouldPostFailedCallbackIfIncorrectResponse")
            return
        }
        XCTAssertNotNil(error)
        expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
}

// MARK: - Undecodable data
func testGetCurrencyShouldPostFailedCallbackIfIncorrectData() {
    // Given
    let fixer = HTTPClient(httpEngine: HTTPEngine(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil)))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    
    fixer.request(baseURL: url, parameters: [("access_key", "173e725be7b0231e46c4f70d08b278eb"), ("symbols", "USD")]) { (result: Result<FixerJSON, NetworkError>) in
        guard case .failure(let error) = result else {
            XCTFail("testGetCurrencyShouldPostFailedCallbackIfIncorrectData")
            return
        }
        
        XCTAssertNotNil(error)
        //Then
        expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.01)
}

// MARK: - Success
func testGetCurrencyShouldPostSuccessCallbackIfNoMissingData() {
    // Given
    let fixer = HTTPClient(httpEngine: HTTPEngine(session: URLSessionFake(data: FakeResponseData.fixerCorrectData, response: FakeResponseData.responseOK, error: nil)))
    // When
    let expectation = XCTestExpectation(description: "Wait for queue change")
    
    fixer.request(baseURL: url, parameters: [("access_key", "173e725be7b0231e46c4f70d08b278eb"), ("symbols", "USD")]) { (result: Result<FixerJSON, NetworkError>) in
        guard case .success(let data) = result else {
            XCTFail("testFixerShouldPostFailedCallbackError")
            return
        }
        
        XCTAssertEqual(data.rates["USD"], 1.120222)
        // Then
        expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 0.01)
}
}
