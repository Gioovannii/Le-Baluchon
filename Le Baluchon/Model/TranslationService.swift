//
//  TranslationService.swift
//  Le Baluchon
//
//  Created by Jonathan Gaffé on 2020/6/13.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation

class TranslationService {
    
    let session: URLSession
    var task: URLSessionDataTask?
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    //MARK: - Network Call.
    func getCurrency(textInput: String,target: String, callback: @escaping (Result<String, NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://translation.googleapis.com/language/translate/v2?key=AIzaSyA7U25Y2ynHepATFgDdEBAHjSvaVIK9WTQ&q=\(textInput)&source=fr&target=\(target)&format=text") else { return }
        
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
            
            guard let responseDecoded = try? JSONDecoder().decode(TranslateJSON.self, from: data) else {
                    callback(.failure(.undecodableData))
                    return
            }
            callback(.success(responseDecoded.data.translations[0].translatedText))
        }
        // start task
        task?.resume()
    }
}
