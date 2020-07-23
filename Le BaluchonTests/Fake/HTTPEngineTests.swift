//
//  HTTPEngine.swift
//  Le BaluchonTests
//
//  Created by Jonathan Gaffé on 2020/7/16.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//
@testable import Le_Baluchon
import XCTest

final class HTTPEngineTests: XCTestCase {
    
    private let url = URL(string: "http://data.fixer.io/api/latest?")!
    private let parameters = [("access_key", "173e725be7b0231e46c4f70d08b278eb"), ("symbols", "USD")]
    
    // MARK: - Error
    func testGetCurrencyShouldPostFailedCallbackError() {
        let httpEngine = HTTPEngine(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        httpEngine.request(baseUrl: url, parameters: parameters) { (data, response, error) in
            
            XCTAssertNil(data)
            XCTAssertNotEqual(response?.statusCode, 200)
            XCTAssertNotNil(error)
            
            // Then
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Error
    func testGetCurrencyShouldPostFailedCallbackErrorr() {
        let httpEngine = HTTPEngine(session: URLSessionFake(data: FakeResponseData.fixerCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        httpEngine.request(baseUrl: url, parameters: parameters) { (data, response, error) in
            
            XCTAssertNotNil(data)
            XCTAssertEqual(response?.statusCode, 500)
            
            // Then
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    
    // MARK: - Success
    func testGetCurrencyShouldPostSuccessCallbackIfNoMissingData() {
        // Given
        let httpEngine = HTTPEngine(session: URLSessionFake(data: FakeResponseData.fixerCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        httpEngine.request(baseUrl: url, parameters: parameters) { (data, response, error) in
            
            XCTAssertNotNil(data)
            expectation.fulfill()
        }
        //            XCTAssertEqual(data.rates["USD"], 1.120222)
        
        // Then
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - HTTPClient No data
    
    func testRequest_ShouldPostFailedCallback_IfError() {
        
        let httpClient = HTTPClient(httpEngine: HTTPEngine(session: URLSessionFake(data: FakeResponseData.incorrectData, response: nil, error: FakeResponseData.error)))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        httpClient.request(baseURL: url, parameters: parameters) { (result: Result<FixerJSON, NetworkError>) in
            
            guard case .failure(let error) = result else {
                XCTFail("testRequest_ShouldPostFailedCallback_IfError")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - HTTPClient No response
    
    func test_ShouldPost_FailedCallBackIf_IncorrectResponse() {
        // Given
        let httpClient = HTTPClient(httpEngine: HTTPEngine(session: URLSessionFake(data: FakeResponseData.fixerCorrectData, response: FakeResponseData.responseKO, error: nil)))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        httpClient.request(baseURL: url, parameters: parameters) { (result: Result<FixerJSON, NetworkError>) in
            
            guard case .failure(let error) = result else {
                XCTFail("test_ShouldPost_FailedCallBackIf_IncorrectResponse")
                return
            }
            
            XCTAssertNotNil(error)
            
            //Then
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    // MARK: - HTTPClient undecodable Data
    
    func test_ShouldPost_FailedCallBackIf_UndecodableData() {
        // Given
        let httpClient = HTTPClient(httpEngine: HTTPEngine(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil)))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        httpClient.request(baseURL: url, parameters: parameters) { (result: Result<FixerJSON, NetworkError>) in
            
            guard case .failure(let error) = result else {
                XCTFail("test_ShouldPost_FailedCallBackIf_UndecodableData")
                return
            }
            
            XCTAssertNotNil(error)
            
            // Then
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: -  HTTPClient Success
    
    func test_ShouldPost_SuccessCallBackIf_NoProblem() {
        // Given
        let httpClient = HTTPClient(httpEngine: HTTPEngine(session: URLSessionFake(data: FakeResponseData.fixerCorrectData, response: FakeResponseData.responseOK, error: nil)))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        httpClient.request(baseURL: url, parameters: parameters) { (result: Result<FixerJSON, NetworkError>) in
            
            guard case .success(let data) = result else {
                XCTFail("test_ShouldPost_FailedCallBackIf_UndecodableData")
                return
            }
            
            XCTAssertNotNil(data)
            
            // Then
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
