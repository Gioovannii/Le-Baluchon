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
    
    let tempNewYork = 22.57
    let tempParis = 20.189
    
    // MARK: - Temperatures
    
    func testGivenTemperatureString_WhenSettingInstance_ThenAssertTransform() {
        
        let cityData = CityData(conditionId: 800, cityName: "Paris", temperature: tempParis)
        
        
        XCTAssertEqual(cityData.temperatureString, "20.2")
    }
    
    // MARK: - Bolt
    
    func testGivenGetWeather_WhenSettingInstance_ThenTestConditionNameBoltNewYork() {
        let cityData = CityData(conditionId: 210, cityName: "New York", temperature: tempNewYork)
        
        XCTAssertEqual(cityData.conditionName, "bolt")
    }
    
    func testGivenGetWeather_WhenSettingInstance_ThenTestConditionNameBoltParis() {
        let cityData = CityData(conditionId: 210, cityName: "Paris", temperature: tempParis)
        
        XCTAssertEqual(cityData.conditionName, "bolt")
    }
    
    // MARK: - Drizzle
    
    func testGivenGetWeather_WhenSettingInstance_ThenTestConditionNameDrizzleNewYork() {
        let cityData = CityData(conditionId: 310, cityName: "New York", temperature: tempNewYork)
        
        XCTAssertEqual(cityData.conditionName, "drizzle")
    }
    
    func testGivenGetWeather_WhenSettingInstance_ThenTestConditionNameDrizzleParis() {
        let cityData = CityData(conditionId: 310, cityName: "Paris", temperature: tempParis)
        
        XCTAssertEqual(cityData.conditionName, "drizzle")
    }
    
    // MARK: - Rain
    
    func testGivenGetWeather_WhenSettingInstance_ThenTestConditionNameRainNewYork() {
        let cityData = CityData(conditionId: 510, cityName: "New York", temperature: tempNewYork)
        
        XCTAssertEqual(cityData.conditionName, "rain")
    }
    
    func testGivenGetWeather_WhenSettingInstance_ThenTestConditionNameRainParis() {
        let cityData = CityData(conditionId: 510, cityName: "Paris", temperature: tempParis)
        
        XCTAssertEqual(cityData.conditionName, "rain")
    }
    
    
    // MARK: - Snow
    
    
    
    func testGivenGetWeather_WhenSettingInstance_ThenTestConditionNameSnowNewYork() {
        let cityData = CityData(conditionId: 610, cityName: "New York", temperature: tempNewYork)
        
        XCTAssertEqual(cityData.conditionName, "snow")
    }
    
    func testGivenGetWeather_WhenSettingInstance_ThenTestConditionNameSnowParis() {
        
        let cityData = CityData(conditionId: 610, cityName: "Paris", temperature: tempParis)
        
        XCTAssertEqual(cityData.conditionName, "snow")
    }
    
    
    // MARK: - Fog
    
    func testGivenGetWeather_WhenSettingInstance_ThenTestConditionNameFogNewYork() {
        let cityData = CityData(conditionId: 710, cityName: "New York", temperature: 20.189)
        
        XCTAssertEqual(cityData.conditionName, "fog")
    }
    
    func testGivenGetWeather_WhenSettingInstance_ThenTestConditionNameFogParis() {
        let cityData = CityData(conditionId: 710, cityName: "Paris", temperature: 20.189)
        
        XCTAssertEqual(cityData.conditionName, "fog")
    }
    
    // MARK: - Sunny
    
    func testGivenGetWeather_WhenSettingInstance_ThenTestConditionNameSunnyNewYork() {
        
        let cityData = CityData(conditionId: 800, cityName: "New York", temperature: 20.189)
        
        XCTAssertEqual(cityData.conditionName, "sunny")
    }
    
    func testGivenGetWeather_WhenSettingInstance_ThenTestConditionNameSunnyParis() {
        
        let cityData = CityData(conditionId: 800, cityName: "Paris", temperature: 20.189)
        
        XCTAssertEqual(cityData.conditionName, "sunny")
    }
    
    
    // MARK: - Cloud
    
    func testGivenGetWeather_WhenSettingInstance_ThenTestConditionNameCloudNewYork() {
        
        let cityData = CityData(conditionId: 802, cityName: "New York", temperature: 20.189)
        
        XCTAssertEqual(cityData.conditionName, "cloud")
    }
    
    func testGivenGetWeather_WhenSettingInstance_ThenTestConditionNameCloudParis() {
        
        let cityData = CityData(conditionId: 802, cityName: "Paris", temperature: 20.189)
        
        XCTAssertEqual(cityData.conditionName, "cloud")
    }
    
    
    // MARK: - Default
    
    func testGivenGetWeather_WhenSettingInstance_ThenTestConditionNameDefault() {
        
        let cityData = CityData(conditionId: 810, cityName: "New York", temperature: 20.189)
        
        XCTAssertEqual(cityData.conditionName, "")
    }
    
    func testGivenGetWeather_WhenSettingInstance_ThenTestConditionNameDefaultParis() {
        
        let cityData = CityData(conditionId: 810, cityName: "Paris", temperature: 20.189)
        
        XCTAssertEqual(cityData.conditionName, "")
    }
}
