//
//  WeatherManager.swift
//  Le Baluchon
//
//  Created by mac on 2020/5/24.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation
enum NetworkError: Error {
      case noData, incorrectResponse, undecodableData
  }

class WeatherService {
    //MARK: - Properties.
    let session: URLSession
    var task: URLSessionDataTask?
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }   
    
    //MARK: - Network Call.
    func getWeatherData(callback: @escaping (Result<WeatherData, NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/group?id=5128581%2C2968815&appid=17121490b9e3ea8f4d54dc0b563f9fb2&units=metric") else { return }
        
        task?.cancel()
        // Give the session a task
        task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                callback(.failure(.noData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(.incorrectResponse))
                return
            }
            
            guard let responseDecoded = self.parseJSON(data) else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(responseDecoded))
        }
        // start task
        task?.resume()
    }
    
    //MARK: - parse Safely.
    /// take the response then handle errors
    func parseJSON(_ weatherData: Data) -> WeatherData? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(WeatherJSON.self, from: weatherData)
            
            let id = decoderData.list[0].weather[0].id
            let temp = decoderData.list[0].main.temp
            let name = decoderData.list[0].name
            
            let idParis = decoderData.list[1].weather[0].id
            let tempParis = decoderData.list[1].main.temp
            let nameParis = decoderData.list[1].name
            
            let weather = WeatherData(conditionId: id, cityName: name, temperature: temp, conditionIdParis: idParis, cityNameParis: nameParis, temperatureParis: tempParis)
            
            return weather
            
        } catch {
            print(error)
            return nil
        }
    }
}
