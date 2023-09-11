//
//  ViewModelType.swift
//  WordGame
//
//  Created by Charmy on 11.09.23.
//

import Foundation

/**
 View Model Type
 
 Object that defines the state of views
 */
protocol ViewModelProtocol: AnyObject {
    associatedtype Input
    associatedtype Output

    /// Input from views (UIButtons, UI changes etc)
    var input: Input { get }
    
    /// Output to change views
    var output: Output { get }
}
