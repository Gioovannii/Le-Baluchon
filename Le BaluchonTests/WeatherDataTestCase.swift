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
    
    // MARK: - Sunny
    func testGetWeatherShouldPostSuccesCallbackIfNoErrorAndCorrectDataSunnyWeather() {
        
        
        
        
        // Given
//        let weather = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
//
//        //When
//        let expectation = XCTestExpectation(description: "Wait for queue change")
//        weather.getWeatherData { result in
//            guard case .success(let data) = result else {
//                XCTFail("testGetWeatherShouldPostSuccesCallbackIfNoErrorAndCorrectData Success")
//                return
//            }
//
//            XCTAssertEqual(data.temperatureString, "16.4")
//            XCTAssertEqual(data.temperatureStringParis, "27.8")
//
//
//            XCTAssertEqual(data.getCondition(to: data.conditionId), "sunny")
//
//            //Then
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Condition Names
    func testGetWeatherShouldPostSuccesCallbackIfNoErrorAndCorrectDataConditionNames() {
        // Given
        let weather = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData,response: FakeResponseData.responseOK, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weather.getWeatherData { result in
            guard case .success(let data) = result else {
                XCTFail("testGetWeatherShouldPostSuccesCallbackIfNoErrorAndCorrectData Success")
                return
            }
            
            XCTAssertEqual(data.conditionName, data.getCondition(to: data.conditionId))
            XCTAssertEqual(data.conditionNameParis, data.getCondition(to: data.conditionIdParis))
            
            //Then
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Bolt
    func testGetWeatherShouldPostSuccesCallbackIfNoErrorAndCorrectDataBolt() {
        // Given
        let weather = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weather.getWeatherData { result in
            guard case .success(let data) = result else {
                XCTFail("testGetWeatherShouldPostSuccesCallbackIfNoErrorAndCorrectData Success")
                return
            }
            
            XCTAssertEqual(data.getCondition(to: 220), "bolt")
            
            //Then
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Drizzle
    func testGetWeatherShouldPostSuccesCallbackIfNoErrorAndCorrectDataDrizzle() {
        // Given
        let weather = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weather.getWeatherData { result in
            guard case .success(let data) = result else {
                XCTFail("testGetWeatherShouldPostSuccesCallbackIfNoErrorAndCorrectData Success")
                return
            }
            
            XCTAssertEqual(data.getCondition(to: 320), "drizzle")
            
            //Then
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Rain
    func testGetWeatherShouldPostSuccesCallbackIfNoErrorAndCorrectDataRain() {
        // Given
        let weather = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weather.getWeatherData { result in
            guard case .success(let data) = result else {
                XCTFail("testGetWeatherShouldPostSuccesCallbackIfNoErrorAndCorrectData Success")
                return
            }
            
            XCTAssertEqual(data.getCondition(to: 520), "rain")
            
            //Then
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Snow
    func testGetWeatherShouldPostSuccesCallbackIfNoErrorAndCorrectDataSnow() {
        // Given
        let weather = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weather.getWeatherData { result in
            guard case .success(let data) = result else {
                XCTFail("testGetWeatherShouldPostSuccesCallbackIfNoErrorAndCorrectData Success")
                return
            }
            
            XCTAssertEqual(data.getCondition(to: 620), "snow")
            
            //Then
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Fog
    func testGetWeatherShouldPostSuccesCallbackIfNoErrorAndCorrectDataFog() {
        // Given
        let weather = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weather.getWeatherData { result in
            guard case .success(let data) = result else {
                XCTFail("testGetWeatherShouldPostSuccesCallbackIfNoErrorAndCorrectData Success")
                return
            }
            
            XCTAssertEqual(data.getCondition(to: 720), "fog")
            
            //Then
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Second bolt
    // FIXME: - Need to change default value already use
    func testGetWeatherShouldPostSuccesCallbackIfNoErrorAndCorrectDataBolte() {
        // Given
        let weather = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weather.getWeatherData { result in
            guard case .success(let data) = result else {
                XCTFail("testGetWeatherShouldPostSuccesCallbackIfNoErrorAndCorrectData Success")
                return
            }
            
            XCTAssertEqual(data.getCondition(to: 803), "cloud")
            
            //Then
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - Default
    func testGetWeatherShouldPostSuccesCallbackIfNoErrorAndCorrectDataDefault() {
        // Given
        let weather = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weather.getWeatherData { result in
            guard case .success(let data) = result else {
                XCTFail("testGetWeatherShouldPostSuccesCallbackIfNoErrorAndCorrectData Success")
                return
            }
            
            XCTAssertEqual(data.getCondition(to: 820), "")
            
            //Then
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
