//
//  TranslateData.swift
//  Le Baluchon
//
//  Created by Jonathan Gaffé on 2020/6/27.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct TranslateJSON: Decodable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Decodable {
    let translations: [Translation]
}

// MARK: - Translation
struct Translation: Decodable {
    let translatedText: String
}
