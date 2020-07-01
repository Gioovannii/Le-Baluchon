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
    
    // MARK: - Error
    func testGetCurrency_ShouldPostFailedCallback_Error() {
        // Given
        let translate = TranslationService(
            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        translate.getCurrency(textInput: "Bonjour") { result in
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
    
    // MARK: - No Data
    func testGetTranslation_ShouldPostFailedCallback_NoResponse() {
        //Given
        let translate = TranslationService(
            session: URLSessionFake(data: FakeResponseData.incorrectData, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        translate.getCurrency(textInput: "Bonjour") { result in
            guard  case .failure(let error) = result else {
                XCTFail("testFixerShouldPostFailedCallBackError")
                return
            }
            XCTAssertNotNil(error)
            
            // Then
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Incorrect Response
    func testGetTranslation_ShouldPostFailedCallback_IncorrectData() {
        //Given
        let translate = TranslationService(
            session: URLSessionFake(data: nil, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        translate.getCurrency(textInput: "Bonjour") { result in
            guard  case .failure(let error) = result else {
                XCTFail("testFixerShouldPostFailedCallBackError")
                return
            }
            XCTAssertNotNil(error)
            
            // Then
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Undecodable Data
    func testGetTranslation_ShouldPostFailedCallback_IncorrectResponse() {
        //Given
        let translate = TranslationService(
            session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        translate.getCurrency(textInput: "Bonjour") { result in
            guard  case .failure(let error) = result else {
                XCTFail("testFixerShouldPostFailedCallBackError")
                return
            }
            XCTAssertNotNil(error)
            
            // Then
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Success
    
    func testGetTranslation_ShouldPostSuccessCallBack_NoErrors() {
        //Given
        let translate = TranslationService(
            session: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        translate.getCurrency(textInput: "Bonjour") { result in
            guard case .success(let data) = result else {
                XCTFail("testFixerShouldPostFailedCallBackError")
                return
            }
            
            XCTAssertEqual(data, "Hello")
            
            // Then
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
