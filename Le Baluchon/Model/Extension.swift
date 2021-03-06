//
//  File.swift
//  Le Baluchon
//
//  Created by Jonathan Gaffé on 2020/7/16.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import UIKit


//Double+Convert 
extension Double {
    var stringDigitFormat: String {
        let formater = NumberFormatter()
        formater.maximumFractionDigits = 3

        guard let resultFormated = formater.string(from: NSNumber(value: self)) else { return String()}
        return resultFormated
    }
}

