//
//  HTTPClient.swift
//  Le Baluchon
//
//  Created by Jonathan Gaffé on 2020/7/6.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation

final class HTTPClient {
    // MARK: - properties
    
    private let httpEngine: HTTPEngine
    
    // MARK: - Initializer
    init(httpEngine: HTTPEngine = HTTPEngine(session: URLSession(configuration: .default))) {
        self.httpEngine = httpEngine
    }
    
    func request<T: Decodable>(baseURL: URL, parameters: [(String, Any)]?, callback: @escaping (Result<T, NetworkError>) -> Void) {
        httpEngine.request(baseUrl: baseURL, parameters: parameters) { data, response, error in
            guard let data = data, error == nil else {
                callback(.failure(.noData))
                return
            }
            
            guard let response = response, response.statusCode == 200 else {
                callback(.failure(.incorrectResponse))
                return
            }
            
            guard let responseDecoded = try? JSONDecoder().decode(T.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(responseDecoded))
        }
    }
}
