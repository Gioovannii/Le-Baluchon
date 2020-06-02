//
//  WeatherData.swift
//  Le Baluchon
//
//  Created by mac on 2020/5/24.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation

struct WeatherJSON: Codable {
    let list: [List]
}

struct List: Codable {
    let name: String
    let weather: [Weather]
    let main: Main
}

struct Main: Codable {
    let temp: Double
}


struct Weather: Codable {
    let description: String
    let id: Int
}


//struct WeatherJSON: Codable {
//    let name: String
//    let main: Main
//    let weather: [Weather]
//}
//
//struct Main: Codable {
//    let temp: Double
//}
//
//struct Weather: Codable {
//    let description: String
//    let id: Int
//}
