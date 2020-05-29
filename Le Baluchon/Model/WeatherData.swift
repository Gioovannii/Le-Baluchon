//
//  WeatherModel.swift
//  Le Baluchon
//
//  Created by mac on 2020/5/24.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation

struct WeatherData {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
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
            return "bolt"
        default:
            return "sad.sun"
        }
    }
}
