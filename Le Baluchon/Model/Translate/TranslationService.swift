//
//  TranslationService.swift
//  Le Baluchon
//
//  Created by Jonathan Gaffé on 2020/6/13.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation

class TranslationService {
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient = HTTPClient()) {
        self.httpClient = httpClient
    }
    
    func getCurrency(textInput: String, target: String, callback: @escaping (Result<TranslateJSON, NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://translation.googleapis.com/language/translate/v2?") else { return }
        
        httpClient.request(baseURL: url, parameters: [("key", "AIzaSyA7U25Y2ynHepATFgDdEBAHjSvaVIK9WTQ"), ("q", textInput), ("target", target), ("model", "base")]) { (result: Result<TranslateJSON, NetworkError>) in
            
            switch result {
            case .success(let text):
                callback(.success(text))
                
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}

