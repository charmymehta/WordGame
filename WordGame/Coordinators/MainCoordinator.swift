//
//  MainCoordinator.swift
//  WordGame
//
//  Created by Charmy on 11.09.23.
//

import UIKit

class MainCoordinator: NSObject, CoordinatorType {
    
    let window: UIWindow
    var gameCoordinator: GameCoordinator?
    
    var rootViewController: UIViewController {
        return UINavigationController()
    }

    init(window: UIWindow) {
        self.window = window
        super.init()
        start()
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        beginTheGame()
    }
    
    private func beginTheGame() {
        guard let navigationController = window.rootViewController as? UINavigationController else { return }
        let gameCoordinator = GameCoordinator(presenter: navigationController)
        gameCoordinator.start()
        self.gameCoordinator = gameCoordinator
    }
}
