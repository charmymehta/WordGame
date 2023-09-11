//
//  CoordinatorType.swift
//  WordGame
//
//  Created by Charmy on 11.09.23.
//

import UIKit

/**
 Coordinator Type
 
 Object that defines the flow of views
 */
protocol CoordinatorType: AnyObject {
    // MARK: - Calls the rootViewController (or any ViewController) which is defined on site
    
    /// Start of flow
    func start()
    
    /// Initial controller
    var rootViewController: UIViewController { get }
}
