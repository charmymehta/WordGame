//
//  TranslationServices.swift
//  WordGame
//
//  Created by Charmy on 11.09.23.
//

import Foundation

class TranslationServices {
    static func getSpanishTranslations() -> [TranslationModel] {
        guard let resourceURL = Bundle.main.url(forResource: "words", withExtension: "json") else {
            return []
        }
        do {
            let data = try Data(contentsOf: resourceURL, options: .mappedIfSafe)
            let translations = try JSONDecoder().decode([TranslationModel].self, from: data)
            return translations
        } catch {
            return []
        }
    }
}
