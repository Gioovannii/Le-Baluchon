//
//  TranslateData.swift
//  Le Baluchon
//
//  Created by Jonathan Gaffé on 2020/6/27.
//  Copyright © 2020 Giovanni Gaffé. All rights reserved.
//

import Foundation

// MARK: - Welcome

struct TranslateJSON: Codable {
    let data: DataClass
}

// MARK: - DataClass

struct DataClass: Codable {
    let translations: [Translation]
}

// MARK: - Translation

struct Translation: Codable {
    let translatedText, detectedSourceLanguage, model: String
}
