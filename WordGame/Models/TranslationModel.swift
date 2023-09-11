//
//  TranslationModel.swift
//  WordGame
//
//  Created by Charmy on 11.09.23.
//

import Foundation

struct TranslationModel: Codable {
    let english: String
    let spanish: String
    
    var isCorrectTranslation = true
    
    private enum CodingKeys: String, CodingKey {
        case english = "text_eng"
        case spanish = "text_spa"
    }
    
    init(english: String, spanish: String, isCorrectTranslation: Bool) {
        self.english = english
        self.spanish = spanish
        self.isCorrectTranslation = isCorrectTranslation
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        english = try container.decode(String.self, forKey: .english)
        spanish = try container.decode(String.self, forKey: .spanish)
        isCorrectTranslation = true
    }
}
