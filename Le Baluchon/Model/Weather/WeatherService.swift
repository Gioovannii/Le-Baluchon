//
//  WeatherManager.swift
//  Le Baluchon
//
//  Created by mac on 2020/5/24.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation


class WeatherService {
    //MARK: - Properties.
    let httpClient: HTTPClient
    var citiesData = [CityData]()
    
    init(httpClient: HTTPClient = HTTPClient()) {
        self.httpClient = httpClient
    }   
    
    //MARK: - Network Call.
    func getWeatherData(callback: @escaping (Result<[CityData], NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/group") else { return }

        
        httpClient.request(baseURL: url, parameters: [("id", "5128581,2968815"), ("appid", Config.weather), ("units", "metric")])  { [unowned self] (result: Result<WeatherJSON, NetworkError>) in
            switch result {
            case .success(let data):
                for i in 0..<data.cnt{
                    let cityData = CityData(conditionId: data.list[i].weather[0].id, cityName: data.list[i].name, temperature: data.list[i].main.temp)
                    self.citiesData.append(cityData)
                }
                callback(.success(self.citiesData))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}
