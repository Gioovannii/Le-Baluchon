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
    
    // MARK: - Error
    func testGetCurrencyShouldPostFailedCallbackError() {
        // Given
        let fixer = FixerService(
            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.fixerError))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")

        fixer.getCurrency(currency: "USD") { result in
            guard case .failure(let error) = result else {
                XCTFail("testFixerShouldPostFailedCallbackError")
                return
            }
            
            XCTAssertNotNil(error)
            
            // Then
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - No data
    func testGetCurrencyShouldPostFailedCallbackIfNodData() {
        // Given
        let fixer = FixerService(
            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.fixerError))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        fixer.getCurrency(currency: "USD") { result in
            guard case .failure(let error) = result else {
                XCTFail("testGetCurrencyShouldPostFailedCallbackIfNodData Fail")
                return
            }
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // FIXME: - Finish to set test
    // MARK: - Incorrect response
    func testGetCurrencyShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let fixer = FixerService(
            session: URLSessionFake(data: nil, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        fixer.getCurrency(currency: "USD")  { result in
            guard case .failure(let error) = result else {
                XCTFail("testGetCurrencyShouldPostFailedCallbackIfIncorrectResponse")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Incorrect data
    func testGetCurrencyShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let fixer = FixerService(
            session: URLSessionFake(data: FakeResponseData.incorrectData, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        fixer.getCurrency(currency: "USD") { result in
            guard case .failure(let error) = result else {
                XCTFail("testGetCurrencyShouldPostFailedCallbackIfIncorrectData")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Success
    func testGetCurrencyShouldPostSuccessCallbackIfNoMissingData() {
        // Given
        let fixer = FixerService(
            session: URLSessionFake(data: FakeResponseData.correctData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        fixer.getCurrency(currency: "USD")  { result in
            guard case .success(let data) = result else {
                XCTFail("testGetCurrencyShouldPostSuccessCallbackIfNoMissingData")
                return

            }
            
            XCTAssertEqual(data, 1.131075)
            expectation.fulfill()

        }
        wait(for: [expectation], timeout: 0.01)
    }
}
