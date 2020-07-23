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
        
        httpClient.request(baseURL: url, parameters: [("access_key", Config.fixer), ("symbols", "USD")]) { (result: (Result<FixerJSON, NetworkError>)) in
            
            switch result {
            case .success(let data):
                callback(.success(data))
                
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}

