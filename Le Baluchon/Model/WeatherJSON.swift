//
//  WeatherData.swift
//  Le Baluchon
//
//  Created by mac on 2020/5/24.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation

struct WeatherJSON: Decodable {
    let list: [List]
}

struct List: Decodable {
    let name: String
    let weather: [Weather]
    let main: Main
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
