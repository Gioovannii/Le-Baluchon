//
//  Le_BaluchonTests.swift
//  Le BaluchonTests
//
//  Created by mac on 2020/6/2.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

@testable import Le_Baluchon
import XCTest

class WeatherServiceTestCase: XCTestCase {
    
    func testGetWeatherShoulPostFailedCallBackError() {
        // Given
        let weather = WeatherService(
            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        weather.getWeatherData { result in
            guard case .failure(let error) = result else {
                XCTFail("testGetWeatherShoulPostFailedCallBackError fail")
                return
            }
            
            XCTAssertNotNil(error)
            
            //Then
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallBackIfNoData() {
        // Given
        let weather = WeatherService(session: URLSessionFake(data: nil, response: nil, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        weather.getWeatherData { result in
            guard case .failure(let error) = result else {
                XCTFail("testGetWeatherShouldPostFailedCallBackIfNoData Fail")
                return
            }
            
            XCTAssertNotNil(error)
            //Then
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedIfIncorrectResponse() {
        // Given
        let weather  = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        weather.getWeatherData { result in
            guard case .failure(let error) = result else {
                XCTFail("testGetWeatherShouldPostFailedIfIncorrectResponse IncorrectResponse")
                return
            }
            
            XCTAssertNotNil(error)
            //Then
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weather = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        weather.getWeatherData { result in
            guard case .failure(let error) = result else {
                XCTFail("testGetWeatherShouldPostFailedCallbackIfIncorrectData IncorrectData")
                return
            }
            
            XCTAssertNotNil(error)
            //Then
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}

