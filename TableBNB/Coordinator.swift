//
//  Coordinator.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/19/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - Coordinator Protocol

protocol Coordinator: class {
    func start()
}

// MARK: - SubCoordinator Protocol
// TODO: - Make the types work!!!! -------> Use protocol composition

protocol SubCoordinator: Coordinator {
    //        associatedtype CoordinatorDelegate: CoordinatorDelegateProtocol
    //        weak var coordinatorDelegate: CoordinatorDelegate? { get set }
}