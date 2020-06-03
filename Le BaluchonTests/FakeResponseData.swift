//
//  FakeResponseData.swift
//  Le BaluchonTests
//
//  Created by mac on 2020/6/2.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation
class FakeResponseData {
    //MARK: - Data
    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: ".json")!
        return try! Data(contentsOf: url)
    }
    
    static let weatherIncorrectData = "erreur".data(using: .utf8)
    static let weatherData = "data".data(using: .utf8)
    
    //MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: nil)
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: nil)
    
    
    //MARK: - Error
    class WeatherError: Error {}
    static let error = WeatherError()
    
}
