//
//  FixerService.swift
//  Le Baluchon
//
//  Created by mac on 2020/6/4.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.


import Foundation

final class FixerService {
    
    let httpClient: HTTPClient
    var task: URLSessionDataTask?
    
    init(httpClient: HTTPClient = HTTPClient()){
        self.httpClient = httpClient
    }
    
    //MARK: - Network Call.
    func getCurrency(currency: String, callback: @escaping (Result<FixerJSON, NetworkError>) -> Void) {
        guard let url = URL(string: "http://data.fixer.io/api/latest?") else { return }
        
        httpClient.request(baseURL: url, parameters: [("access_key", "173e725be7b0231e46c4f70d08b278eb"), ("symbols", "USD")]) { (result: (Result<FixerJSON, NetworkError>)) in
            
            switch result {
            case .success(let data):
                callback(.success(data))
                
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}

extension FixerService {
//    
//    /// Format to 3 digit
//       public func formatResult(number: Double) -> String {
//           let formater = NumberFormatter()
//           formater.maximumFractionDigits = 3
//
//           guard let resultFormated = formater.string(from: NSNumber(value: number)) else { return String()}
//           return resultFormated
//       }
}

extension Double {
    var stringDigitFormat: String {
        let formater = NumberFormatter()
        formater.maximumFractionDigits = 3

        guard let resultFormated = formater.string(from: NSNumber(value: self)) else { return String()}
        return resultFormated
    }
}

