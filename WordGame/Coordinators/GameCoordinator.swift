//
//  GameCoordinator.swift
//  WordGame
//
//  Created by Charmy on 11.09.23.
//

import UIKit

class GameCoordinator: CoordinatorType {
    private let presenter: UINavigationController
    private let gameViewController: GameViewController

    var rootViewController: UIViewController {
        return gameViewController
    }
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        let gameViewModel = GameViewModel(correctTranslationProbability: 25)    // Probability between 1...100
        gameViewController = GameViewController()
        gameViewController.configure(with: gameViewModel)
    }
    
    func start() {
        presenter.pushViewController(rootViewController, animated: true)
    }
}
