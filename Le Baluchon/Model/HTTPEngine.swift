//
//  HTTPEngine.swift
//  Le Baluchon
//
//  Created by Jonathan Gaffé on 2020/7/2.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation

typealias HTTPResponse = (Data?, HTTPURLResponse?, Error?) -> Void

final class HTTPEngine {
    
    // MARK: - Properties
    private let session: URLSession
    private var task: URLSessionDataTask?
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    //MARK: - Methods
    /// Url request
    /// - Parameters:
    ///   - baseUrl: without parameters
    ///   - parameters: parameters encoded
    ///   - callback: closure with diferent responses
    func request(baseUrl: URL, parameters: [(String, Any)]?, callback: @escaping HTTPResponse) {
        let url = encode(baseUrl: baseUrl, with: parameters)
        Logger(url: url).show()
        task?.cancel()
        task = session.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                callback(data, nil, error)
                return
            }
            callback(data, response, error)
        }
        task?.resume()
    }
    
    /// Encoding
    /// - Parameters:
    ///   - baseUrl: Without any parameters
    ///   - parameters: Differents api provide by API
    /// - Returns: Final complete url
    private func encode(baseUrl: URL, with parameters: [(String, Any)]?) -> URL {
        guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false), let parameters = parameters, !parameters.isEmpty else { return baseUrl }
        urlComponents.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let querryItem = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems?.append(querryItem)
        }
        guard let url = urlComponents.url else { return baseUrl }
        return url
    }
}
