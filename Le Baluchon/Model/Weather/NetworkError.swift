//
//  NetworkError.swift
//  Le Baluchon
//
//  Created by Jonathan Gaffé on 2020/7/16.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case noData
    case incorrectResponse
    case undecodableData
    case badInput
    
    var description: String {
        switch self {
        case .noData:
            return "There is no data"
        case .incorrectResponse:
            return "There is no response"
        case .undecodableData:
            return "Data is undecodable"
        case .badInput:
            return "Please check you write in french"
        }
    }
}
