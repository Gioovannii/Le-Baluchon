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
    
    func testGetWeather_ShouldPostCallbackSuccessWhenAlldCorrectData() {
        let fixer = WeatherService(httpClient: HTTPClient(httpEngine: HTTPEngine(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))))
        
        fixer.getWeatherData { (result: Result<[CityData], NetworkError>) in
            guard case .success(let data) = result else { return }
            
            let setData : [Any] = ["New York City", 803, "cloud", "Paris", 804, "cloud"]

            XCTAssertEqual(data[0].cityName, setData[0] as? String)//"New York City")
            XCTAssertEqual(data[0].conditionId, setData[1] as! Int)   //803
            XCTAssertEqual(data[0].conditionName, setData[2] as? String)   //"cloud"

            XCTAssertEqual(data[1].cityName, setData[3] as? String) //"Paris"
            XCTAssertEqual(data[1].conditionId, setData[4] as! Int) //804
            XCTAssertEqual(data[1].conditionName, setData[5] as?String) //"cloud"
        }
    }
    
    func testGetWeather_ShouldPostCallbaackFailled_WhenError() {
        let weather = WeatherService(httpClient: HTTPClient(httpEngine: HTTPEngine(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseKO, error: nil))))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weather.getWeatherData { (result: Result<[CityData], NetworkError>) in
        guard case .failure(let error) = result else { return }
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
    }

}

