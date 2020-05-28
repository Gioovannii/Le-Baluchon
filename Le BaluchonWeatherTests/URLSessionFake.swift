//
//  URLSessionFake.swift
//  Le BaluchonWeatherTests
//
//  Created by mac on 2020/5/25.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation

class URLSessionFake: URLSession {
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    
    
}
