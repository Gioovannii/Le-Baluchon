//
//  WeatherModel.swift
//  Le Baluchon
//
//  Created by mac on 2020/5/24.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
     let cityName: String
     let temperature: Double
     
     var temperatureString: String {
         return String(format: "%.1f", temperature)
     }
}
