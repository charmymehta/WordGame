//
//  GameViewModelTests.swift
//  WordGameTests
//
//  Created by Charmy on 11.09.23.
//

import XCTest
@testable import WordGame

final class GameViewModelTests: XCTestCase {

    var subject: GameViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        subject = GameViewModel(correctTranslationProbability: 25, maxTranslationsPerGame: 15, maxWrongAttemptsPerGame: 3)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        subject = nil
    }

    func testPrepare_Word_Pair_Success() {
        var englishWord = ""
        var spanishWord = ""
        subject.output.updateTranslationPair = { english, spanish in
            englishWord = english
            spanishWord = spanish
        }
        
        XCTAssertNil(subject.currentTranslationPair)

        subject.prepareTranslationPair()
        XCTAssertNotNil(subject.currentTranslationPair)
        XCTAssertFalse(englishWord.isEmpty)
        XCTAssertFalse(spanishWord.isEmpty)
    }
    
    //   Correct translation ->  User pressed correct button == Correct Attempt
    func test_Correct_Attempt_With_Correct_Button_Press() {
        var correctAttempts = 0
        var wrongAttempts = 0
        subject.output.updateAttemptsCounter = { correctAttemptCounter, wrongAttemptCounter in
            correctAttempts = correctAttemptCounter
            wrongAttempts = wrongAttemptCounter
        }
        subject.currentTranslationPair = TranslationModel(english: "English Word", spanish: "Spanish Word", isCorrectTranslation: true)
        subject.input.checkCorrectAnswer(true)
        XCTAssertTrue(correctAttempts == 1)
        XCTAssertTrue(wrongAttempts == 0)
    }
    
    //   Wrong translation ->  User pressed correct button == Wrong Attempt
    func test_Wrong_Attempt_With_Correct_Button_Press() {
        var correctAttempts = 0
        var wrongAttempts = 0
        subject.output.updateAttemptsCounter = { correctAttemptCounter, wrongAttemptCounter in
            correctAttempts = correctAttemptCounter
            wrongAttempts = wrongAttemptCounter
        }
        subject.currentTranslationPair = TranslationModel(english: "English Word", spanish: "Spanish Word", isCorrectTranslation: false)
        subject.input.checkCorrectAnswer(true)
        XCTAssertTrue(correctAttempts == 0)
        XCTAssertTrue(wrongAttempts == 1)
    }
    
    //   Wrong translation ->  User pressed wrong button == Correct Attempt
    func test_Correct_Attempt_With_Wrong_Button_Press() {
        var correctAttempts = 0
        var wrongAttempts = 0
        subject.output.updateAttemptsCounter = { correctAttemptCounter, wrongAttemptCounter in
            correctAttempts = correctAttemptCounter
            wrongAttempts = wrongAttemptCounter
        }
        subject.currentTranslationPair = TranslationModel(english: "English Word", spanish: "Spanish Word", isCorrectTranslation: false)
        subject.input.checkCorrectAnswer(false)
        XCTAssertTrue(correctAttempts == 1)
        XCTAssertTrue(wrongAttempts == 0)
    }
    
    //   Correct translation ->  User pressed wrong button == Wrong Attempt
    func test_Wrong_Attempt_With_Wrong_Button_Press() {
        var correctAttempts = 0
        var wrongAttempts = 0
        subject.output.updateAttemptsCounter = { correctAttemptCounter, wrongAttemptCounter in
            correctAttempts = correctAttemptCounter
            wrongAttempts = wrongAttemptCounter
        }
        subject.currentTranslationPair = TranslationModel(english: "English Word", spanish: "Spanish Word", isCorrectTranslation: true)
        subject.input.checkCorrectAnswer(false)
        XCTAssertTrue(correctAttempts == 0)
        XCTAssertTrue(wrongAttempts == 1)
    }
    
    func test_Game_Over_When_Max_Translations_Per_Game_Excceds() {
        var showGameOverWasCalled = false
        subject.output.showGameOver = {
            showGameOverWasCalled = true
        }
        var askedTranslations = 0
        for _ in 0...subject.maxTranslationsPerGame {
            subject.currentTranslationPair = TranslationModel(english: "English Word", spanish: "Spanish Word", isCorrectTranslation: true)
            subject.input.checkCorrectAnswer(true)
            if showGameOverWasCalled {
                break
            }
            askedTranslations += 1
        }
        XCTAssertTrue(askedTranslations == subject.maxTranslationsPerGame && showGameOverWasCalled)
    }
    
    func test_Game_Over_When_Max_WrongAttempts_Per_Game_Excceds() {
        var showGameOverWasCalled = false
        subject.output.showGameOver = {
            showGameOverWasCalled = true
        }
        
        var askedTranslations = 0
        for _ in 0...subject.maxTranslationsPerGame {
            subject.currentTranslationPair = TranslationModel(english: "English Word", spanish: "Spanish Word", isCorrectTranslation: true)
            subject.input.checkCorrectAnswer(false)
            if showGameOverWasCalled {
                break
            }
            askedTranslations += 1
        }
        XCTAssertTrue(askedTranslations < subject.maxTranslationsPerGame && showGameOverWasCalled)
    }
}
