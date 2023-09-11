//
//  ControllerType.swift
//  WordGame
//
//  Created by Charmy on 11.09.23.
//

import Foundation

/**
 Controller Type
 
 Object that defines the communication between View and ViewModel
 */
protocol ControllerType: AnyObject {
    associatedtype ViewModelType: ViewModelProtocol
    
    func configure(with viewModel: ViewModelType)
}
