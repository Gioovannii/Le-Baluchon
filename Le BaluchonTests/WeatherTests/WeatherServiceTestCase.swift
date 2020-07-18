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
    
    let url = URL(string: "https://api.openweathermap.org/data/2.5/group")
    let parameters = [("id", "5128581,2968815"), ("appid", "17121490b9e3ea8f4d54dc0b563f9fb2"), ("units", "metric")]
    
    func testGetWeather_ShouldPostCallbackSuccessWhenAlldCorrectData() {
        let fixer = WeatherService(httpClient: HTTPClient(httpEngine: HTTPEngine(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))))
        
        fixer.getWeatherData { (result: Result<[CityData], NetworkError>) in
            guard case .success(let data) = result else { return }
            
            let setData : [Any] = ["New York City", 803, "cloud", "Paris", 804, "cloud"]

            for i in 0...2 {
                        XCTAssertEqual(data[i].cityName, setData[i] as? String)//"New York City")
                        XCTAssertEqual(data[i].conditionId, setData[i + 1] as! Int)   //803
                        XCTAssertEqual(data[i].conditionName, setData[i + 2] as? String)   //"cloud"
            }
            
//
//            XCTAssertEqual(data[0].cityName, setData[0] as? String)//"New York City")
//            XCTAssertEqual(data[0].conditionId, setData[1] as! Int)   //803
//            XCTAssertEqual(data[0].conditionName, setData[2] as? String)   //"cloud"
//
//            XCTAssertEqual(data[1].cityName, setData[3] as? String) //"Paris"
//            XCTAssertEqual(data[1].conditionId, setData[4] as! Int) //804
//            XCTAssertEqual(data[1].conditionName, setData[5] as?String) //"cloud"
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
//    // MARK: - 1. Error
//    func testGetWeatherShoulPostFailedCallBackError() {
//        // Given
//        let weather = WeatherService(
//            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
//
//        //When
//        let expectation = XCTestExpectation(description: "Wait for queue change")
//
//        weather.getWeatherData { result in
//            guard case .failure(let error) = result else {
//                XCTFail("testGetWeatherShoulPostFailedCallBackError fail")
//                return
//            }
//
//            XCTAssertNotNil(error)
//
//            //Then
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    // MARK: - 2. No data
//    func testGetWeatherShouldPostFailedCallBackIfNoData() {
//        // Given
//        let weather = WeatherService(session: URLSessionFake(data: nil, response: nil, error: nil))
//
//        //When
//        let expectation = XCTestExpectation(description: "Wait for queue change")
//
//        weather.getWeatherData { result in
//            guard case .failure(let error) = result else {
//                XCTFail("testGetWeatherShouldPostFailedCallBackIfNoData Fail")
//                return
//            }
//
//            XCTAssertNotNil(error)
//            //Then
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    // MARK: - 3. Incorrct response
//    func testGetWeatherShouldPostFailedIfIncorrectResponse() {
//        // Given
//        let weather  = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil))
//
//        //When
//        let expectation = XCTestExpectation(description: "Wait for queue change")
//
//        weather.getWeatherData { result in
//            guard case .failure(let error) = result else {
//                XCTFail("testGetWeatherShouldPostFailedIfIncorrectResponse IncorrectResponse")
//                return
//            }
//
//            XCTAssertNotNil(error)
//            //Then
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//    // MARK: - 4. Incorrect data
//    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
//        // Given
//        let weather = WeatherService(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
//
//        //When
//        let expectation = XCTestExpectation(description: "Wait for queue change")
//
//        weather.getWeatherData { result in
//            guard case .failure(let error) = result else {
//                XCTFail("testGetWeatherShouldPostFailedCallbackIfIncorrectData IncorrectData")
//                return
//            }
//
//            XCTAssertNotNil(error)
//            //Then
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 0.01)
//    }
//
//
//    // MARK: - Success Data
//
//    func testGetWeatherShouldPostSuccessCallbackIfNoErrors() {
//          // Given
//        let weather = WeatherService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
//
//          //When
//          let expectation = XCTestExpectation(description: "Wait for queue change")
//
//          weather.getWeatherData { result in
//            guard case .success(let data) = result else {
//                  XCTFail("testGetWeatherShouldPostFailedCallbackIfIncorrectData IncorrectData")
//                  return
//              }
//
//              XCTAssertNotNil(data)
//              //Then
//              expectation.fulfill()
//          }
//
//          wait(for: [expectation], timeout: 0.01)
//      }
//
}

