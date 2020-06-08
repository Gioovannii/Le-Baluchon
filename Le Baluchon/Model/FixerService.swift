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
    
    //MARK: - Network Call.
    func getCurrency(callback: @escaping (Result<Double, NetworkError>) -> Void) {
        let baseUrl = "http://data.fixer.io/api/latest?access_key="
        let apiAccessKey =  "173e725be7b0231e46c4f70d08b278eb"
        let currency = "&symbols=USD&format=1"
        
        guard let url = URL(string: "\(baseUrl)\(apiAccessKey)&\(currency)") else { return }
        
        print(url)
        task?.cancel()
        // We give the session a task
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
    
   // TODO: - to upgrade

    
    
 
    func parseJSON(_ fixerData: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(FixerJSON.self, from: fixerData)
            let currency = decoderData.rates[0].USD
            return currency
            
        } catch {
            print(error)
            return nil
        }
    }
    
    
}


