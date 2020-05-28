//
//  WeatherManager.swift
//  Le Baluchon
//
//  Created by mac on 2020/5/24.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherService {
    
    //MARK: - Properties
     let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=17121490b9e3ea8f4d54dc0b563f9fb2&units=metric")!
    
    
       
    let session: URLSession
    var task: URLSessionDataTask?
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    enum NetworkError: Error {
        case noData, incorrectResponse, undecodableData
    }
    
    //MARK: - Fetch Methods
    /// Get cityName
    //    func fetchWeather(cityName: String) {
    //        let urlString = "\(weatherURL)&q=\(cityName)"
    //        performRequest(with: urlString)
    //        print(urlString)
    //    }
    //
    //    /// Fetch by location
    //    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
    //        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
    //        performRequest(with: urlString)
    //    }
    
    
   
    //MARK: - Network Call
    func getWeatherData(callback: @escaping (Result<WeatherData, NetworkError>) -> Void) {
        task?.cancel()
        // We give the session a task
        task = session.dataTask(with: weatherURL) { data, response, error in
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
        // start task
        task?.resume()
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decoderData.weather[0].id
            let temp = decoderData.main.temp
            let name = decoderData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        } catch {
            
            print(error)
            return nil
        }
    }
}
