//
//  WeatherDataTestCase.swift
//  Le BaluchonTests
//
//  Created by Jonathan Gaffé on 08/06/2020.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//
@testable import Le_Baluchon
import XCTest

class WeatherDataTestCase: XCTestCase {
    
    func testGetWeatherShouldPostSuccesCallbackIfNoErrorAndCorrectData() {
        // Given
        let weather = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weather.getWeatherData { result in
            guard case .success(let data) = result else {
                XCTFail("testGetWeatherShouldPostSuccesCallbackIfNoErrorAndCorrectData Success")
                return
            }
            
            XCTAssertEqual(data.temperatureString, "16.4")
            XCTAssertEqual(data.temperatureStringParis, "27.8")
            
            
            XCTAssertEqual(data.getCondition(to: data.conditionId), "sunny")
            XCTAssertNotEqual(data.getCondition(to: data.conditionId), "rain")
            XCTAssertNotEqual(data.getCondition(to: data.conditionId), "drizzle")
            
            //Then
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
