//
//  GameViewModel.swift
//  WordGame
//
//  Created by Charmy on 11.09.23.
//

import Foundation

class GameViewModel: ViewModelProtocol {
    struct Input {
        var checkCorrectAnswer: (Bool) -> Void
    }
    
    /// Output values / events to Update UI view
    struct Output {
        var updateAttemptsCounter: (Int, Int) -> Void
        var updateTranslationPair: (String, String) -> Void
    }
    
    var input: Input
    var output: Output
    var currentTranslationPair: TranslationModel?

    private let correctTranslationProbability: Int
    private var translationList = [TranslationModel]()
    private var correctAttempts = 0
    private var wrongAttempts = 0
    
    // MARK: - Initialization
    init(correctTranslationProbability: Int) {
        input = Input(checkCorrectAnswer: {isCorrectTranslation in })
        output = Output(updateAttemptsCounter: {correctAttempts, wrongAttempts in },
                        updateTranslationPair: {english, spanish in })
        self.correctTranslationProbability = correctTranslationProbability
        input.checkCorrectAnswer = checkCorrectAnswer
        translationList = getTranslations()
    }
    
    // MARK: - Business logic
    func prepareTranslationPair() {
        currentTranslationPair = nil
        guard !translationList.isEmpty, correctTranslationProbability > 0 && correctTranslationProbability <= 100 else {
            return
        }
        chooseRandomEnglishWord()
    }
    
    private func chooseRandomEnglishWord() {
        let randomTranslationIndex = Int.random(in: 0..<translationList.count)
        let randomTranslation = translationList[randomTranslationIndex]
        translationList.remove(at: randomTranslationIndex)                      // Remove the translation from original list once used
        chooseRandomSpanishWord(for: randomTranslation)
    }
    
    private func chooseRandomSpanishWord(for translation: TranslationModel) {
        //print("==== Spanish translation: \(translation.spanish) ====")
        let englishWord = translation.english
        let correctTranslation = translation.spanish
        
        let wrongTranslationProbability = 100 - correctTranslationProbability
        
        // Prepare list of X incorrect translations, X = 100 - probability
        var spanishWords = translationList.map { $0.spanish }
        while spanishWords.count < wrongTranslationProbability {
            spanishWords += spanishWords
        }
        // We got enough incorrect translations
        spanishWords = Array(spanishWords[0..<wrongTranslationProbability])
        
        // Add correct translation to the list for X times
        spanishWords += Array(repeating: correctTranslation, count: correctTranslationProbability)
        
        // Here we got 100 spanish words in random order, containing correct translation for X times. X = probability
        spanishWords.shuffle()
        
        guard let randomSpanishWord = spanishWords.randomElement() else {
            return
        }
        let translationPair = TranslationModel(english: englishWord, spanish: randomSpanishWord, isCorrectTranslation: randomSpanishWord == correctTranslation)
        self.currentTranslationPair = translationPair
        output.updateTranslationPair(translationPair.english, translationPair.spanish)
    }
    
    private func checkCorrectAnswer(isCorrectTranslation: Bool) {
        guard let currentTranslationPair = currentTranslationPair else {
            return
        }
        if isCorrectTranslation == currentTranslationPair.isCorrectTranslation {
            correctAttempts += 1
        } else {
            wrongAttempts += 1
        }
        output.updateAttemptsCounter(correctAttempts, wrongAttempts)
        prepareTranslationPair()
    }
    
    // MARK: - API/Network calls
    private func getTranslations() -> [TranslationModel] {
        return TranslationServices.getSpanishTranslations()
    }
}
