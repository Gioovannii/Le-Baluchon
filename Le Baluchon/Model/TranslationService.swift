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
 
    // https://translation.googleapis.com/language/translate/v2?key=AIzaSyA7U25Y2ynHepATFgDdEBAHjSvaVIK9WTQ&q=Bonjour&source=fr&target=en&format=text
    
//    //MARK: - Network Call.
//    func getCurrency(callback: @escaping (Result<String, NetworkError>) -> Void) {
//        let baseUrl = "https://translation.googleapis.com/language/translate/v2"
//        let apiKey =  "?key=AIzaSyA7U25Y2ynHepATFgDdEBAHjSvaVIK9WTQ"
//
//        guard let url = URL(string: "\(baseUrl)\(apiKey)&q=Bonjour&source=fr&target=en&format=text") else { return }
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
//            guard let responseDecoded = try? JSONDecoder().decode(ModelData.self, from: data),
//                let text = responseDecoded else {
//                    callback(.failure(.undecodableData))
//                    return
//            }
//            callback(.success(text))
//        }
//        // start task
//        task?.resume()
//    }
    }
