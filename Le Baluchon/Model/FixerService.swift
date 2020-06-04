//
//  FixerService.swift
//  Le Baluchon
//
//  Created by mac on 2020/6/4.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation

final class FixerService {
    
    let session: URLSession
    var task: URLSessionDataTask?
    
    init(session: URLSession = URLSession(configuration: .default)){
        self.session = session
        
    }
    
    enum NetworkError: Error {
        case noData, incorrectResponse, undecodableData
    }
    
    
//    //MARK: - Network Call.
//    func getCurrency(callback: @escaping (Result<WeatherData, NetworkError>) -> Void) {
//        let baseUrl = "http://data.fixer.io/api/latest?access_key="
//        let apiAccessKey =  "173e725be7b0231e46c4f70d08b278eb"
//        let currency = "&symbols=USD&format=1"
//
//        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=\(apiAccessKey)&\(currency)") else { return }
//
//        print(url)
//        task?.cancel()
//        // We give the session a task
//        task = session.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                callback(.failure(.noData))
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                callback(.failure(.incorrectResponse))
//                return
//            }
//
//            guard let responseDecoded = self.parseJSON(data) else {
//                callback(.failure(.undecodableData))
//                return
//            }
//            callback(.success(responseDecoded))
//        }
//        // start task
//        task?.resume()
//    }
    
//        func parseJSON(_ fixerData: Data) -> FixerData {
//        let decoder = JSONDecoder()
//               do {
//                   let decoderData = try decoder.decode(FixerData.self, from: fixerData)
//
//                   let id = decoderData.list[0].weather[0].id
//                   let temp = decoderData.list[0].main.temp
//                   let name = decoderData.list[0].name
//
//                   let idParis = decoderData.list[1].weather[0].id
//                   let tempParis = decoderData.list[1].main.temp
//                   let nameParis = decoderData.list[1].name
//
//                   let weather = WeatherData(conditionId: id, cityName: name, temperature: temp, conditionIdParis: idParis, cityNameParis: nameParis, temperatureParis: tempParis)
//
//                   return weather
//
//               } catch {
//                   print(error)
//                   return nil
//               }
//           }
//    }
}

