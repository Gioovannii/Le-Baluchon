//
//  WeatherModel.swift
//  Le Baluchon
//
//  Created by mac on 2020/5/24.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation

struct WeatherData {
    
    // MARK: - Properties
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    let conditionIdParis: Int
    let cityNameParis: String
    let temperatureParis: Double
    
    
    
    // Convert temperature into String to one decimal number
    var temperatureString: String { return String(format: "%.1f", temperature) }
    var temperatureStringParis: String { return String(format: "%.1f", temperatureParis) }
    
    // check with calculate properties which value should be return to set imageView
    var conditionName: String { getCondition(to: conditionId) }
    var conditionNameParis: String { getCondition(to: conditionIdParis) }
    
    // Check the weather then give back image to show
    func getCondition(to id: Int) -> String {
        switch id {
        case 200...232:
            return "bolt"
        case 300...321:
            return "drizzle"
        case 500...531:
            return "rain"
        case 600...622:
            return "snow"
        case 701...781:
            return "fog"
        case 800:
            return "sunny"
        case 801...804:
            return "cloud"
        default:
            return ""
        }
    }
}
