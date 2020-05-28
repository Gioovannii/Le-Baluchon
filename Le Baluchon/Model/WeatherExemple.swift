//
//  WeatherExemple.swift
//  Le Baluchon
//
//  Created by mac on 2020/5/25.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation

class WeatherExemple {
    let session: URLSession
    var task: URLSessionDataTask?
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    enum NetworkError: Error {
        case noData, incorrectResponse, undecodableData
    }
    
    func getWeatherData(callback: @escaping (Result<WeatherData, NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=17121490b9e3ea8f4d54dc0b563f9fb2&units=metric&q=Marseille") else { return }
        
        task?.cancel()
        
        task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                callback(.failure(.noData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(.incorrectResponse))
                return
            }
            
            guard let responseDecoded = try? JSONDecoder().decode(WeatherData.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(responseDecoded))
        }
        task?.resume()
    }
}

