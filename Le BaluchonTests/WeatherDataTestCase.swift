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
    
    func setConditionId(conditionId: Int, conditionParis: Int) -> WeatherData {
        let weather = WeatherData(conditionId: conditionId, cityName: "New york City", temperature: 20.192, conditionIdParis: conditionParis, cityNameParis: "Paris", temperatureParis: 20.189)
        
        return weather
    }
    
    // MARK: - Temperatures
    func test1() {
        let weatherData = WeatherData(conditionId: 800, cityName: "New york City", temperature: 20.192, conditionIdParis: 800, cityNameParis: "Paris", temperatureParis: 20.189)
        
        XCTAssertEqual(weatherData.temperatureString, "20.2")
    }
    
    func test2() {
           let weatherData = WeatherData(conditionId: 800, cityName: "New york City", temperature: 20.192, conditionIdParis: 800, cityNameParis: "Paris", temperatureParis: 20.189)
           
           XCTAssertEqual(weatherData.temperatureStringParis, "20.2")
       }
    
    // MARK: - Bolt
       func test3() {
       let weatherData =  setConditionId(conditionId: 210, conditionParis: 800)
           
           XCTAssertEqual(weatherData.conditionName, "bolt")
       }
       
       func test4() {
              let weatherData = setConditionId(conditionId: 800, conditionParis: 210)
              
              XCTAssertEqual(weatherData.conditionNameParis, "bolt")
          }
  
    // MARK: - Drizzle
   func test7() {
    
    let weatherData = setConditionId(conditionId: 310, conditionParis: 800)
          
          XCTAssertEqual(weatherData.conditionName, "drizzle")
      }
      
      func test8() {
           let weatherData = setConditionId(conditionId: 800, conditionParis: 310)
          
          XCTAssertEqual(weatherData.conditionNameParis, "drizzle")
      }
    // MARK: - Rain
    func test9() {
         let weatherData = setConditionId(conditionId: 510, conditionParis: 800)
        
        XCTAssertEqual(weatherData.conditionName, "rain")
    }
    
    func test10() {
         let weatherData = setConditionId(conditionId: 800, conditionParis: 510)
        
        XCTAssertEqual(weatherData.conditionNameParis, "rain")
    }
    
    // MARK: - Snow
    func test11() {
         let weatherData = setConditionId(conditionId: 610, conditionParis: 800)
        
        XCTAssertEqual(weatherData.conditionName, "snow")
    }
    
    func test12() {
         let weatherData = setConditionId(conditionId: 800, conditionParis: 610)
        
        XCTAssertEqual(weatherData.conditionNameParis, "snow")
    }
    
    
    // MARK: - Fog
    func test13() {
            let weatherData = setConditionId(conditionId: 710, conditionParis: 800)
           
           XCTAssertEqual(weatherData.conditionName, "fog")
       }
       
       func test14() {
            let weatherData = setConditionId(conditionId: 800, conditionParis: 710)
           
           XCTAssertEqual(weatherData.conditionNameParis, "fog")
       }


    
    // MARK: - Sunny
       func test15() {
               let weatherData = setConditionId(conditionId: 800, conditionParis: 800)
              
              XCTAssertEqual(weatherData.conditionName, "sunny")
          }
          
          func test16() {
               let weatherData = setConditionId(conditionId: 800, conditionParis: 800)
              
              XCTAssertEqual(weatherData.conditionNameParis, "sunny")
          }
    
    // MARK: - Cloud
    func test17() {
         let weatherData = setConditionId(conditionId: 802, conditionParis: 800)
        
        XCTAssertEqual(weatherData.conditionName, "cloud")
    }
    
    func test18() {
         let weatherData = setConditionId(conditionId: 800, conditionParis: 802)
        
        XCTAssertEqual(weatherData.conditionNameParis, "cloud")
    }
    
    // MARK: - Default
    func test19() {
         let weatherData = setConditionId(conditionId: 810, conditionParis: 800)
        
        XCTAssertEqual(weatherData.conditionName, "")
    }
    
    func test20() {
         let weatherData = setConditionId(conditionId: 800, conditionParis: 810)
        
        XCTAssertEqual(weatherData.conditionNameParis, "")
    }
}
