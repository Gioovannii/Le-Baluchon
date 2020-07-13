//
//  Logger.swift
//  Le Baluchon
//
//  Created by Jonathan Gaffé on 2020/7/3.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation

struct Logger {

    // MARK: - Properties

    var url: URL
    private var request : URLRequest {
        return URLRequest(url: url)
    }

    func show() {
        defer { print("== END ==") }
        
        guard let httpMethod = request.httpMethod else { return }
        guard let stringUrl = request.url?.absoluteString else { return }
        guard let urlComponents = NSURLComponents(string: stringUrl) else { return }
        guard let host = urlComponents.host else { return }
        guard let path = urlComponents.path else { return }
        let query = urlComponents.query ?? String()
        
        let logOutput = """
        
        HTTP Method : \(httpMethod)
        URL : \(stringUrl)
        Host : \(host)
        Path : \(path)
        Query : \(query)
        """
        
        print("Request")
        print(logOutput)
    }
}
