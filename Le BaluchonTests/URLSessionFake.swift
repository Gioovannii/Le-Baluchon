//
//  URLSessionFake.swift
//  Le BaluchonTests
//
//  Created by mac on 2020/6/2.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation
class URLSessionFake: URLSession {
    
 //MARK: - Properties.
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    //MARK: - Override methods
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake(data: data, urlResponse: response, responseError: error, completionHandler: completionHandler)
        return task
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake(data: data, urlResponse: response, responseError: error, completionHandler: completionHandler)
        return task
    }
}

// MARK: - DataTasks
class URLSessionDataTaskFake: URLSessionDataTask {
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    var data: Data?
    var urlResponse: URLResponse?
    var responseError: Error?
    
    init(data: Data?, urlResponse: URLResponse?, responseError: Error?, completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) {
        self.data = data
        self.urlResponse = urlResponse
        self.responseError = responseError
        self.completionHandler = completionHandler
    }
    
    override func resume() {
        completionHandler?(data, urlResponse, responseError)
    }
    
    override func cancel() {}
}
