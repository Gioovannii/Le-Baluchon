//
//  FixerData.swift
//  Le Baluchon
//
//  Created by mac on 2020/6/4.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation

struct FixerJSON: Codable {
    let rates: [Rate]
}

struct Rate: Codable {
    let USD: Double
   
}
