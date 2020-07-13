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
    func getCurrency(currency: String, callback: @escaping (Result<Double, NetworkError>) -> Void) {
        guard let url = URL(string: "http://data.fixer.io/api/latest?") else { return }
        
        httpClient.request(baseURL: url, parameters: [("access_key", "173e725be7b0231e46c4f70d08b278eb"), ("symbols", "USD")]) { [unowned self](result: (Result<FixerJSON, NetworkError>)) in
            
        }
    }
}

extension FixerService {
    
    /// Format to 3 digit
       public func formatResult(number: Double) -> String {
           let formater = NumberFormatter()
           formater.maximumFractionDigits = 3

           guard let resultFormated = formater.string(from: NSNumber(value: number)) else { return String()}
           return resultFormated
       }
}

