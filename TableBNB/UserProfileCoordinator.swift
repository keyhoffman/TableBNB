//
//  UserProfileCoordinator.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UserProfileCoordinatorDelegate Protocol

protocol UserProfileCoordinatorDelegate: class {
    
}

// MARK: - UserProfileCoordinator

final class UserProfileCoordinator: SubCoordinator {
    
    // MARK: - UserProfileCoordinatorDelegate Declaration
    
    weak var coordinatorDelegate: UserProfileCoordinatorDelegate?
    
    // MARK: - NavigationController Declaration
    
    private let navigationController: UINavigationController
    
    // MARK: - ViewContoller Declaration
    
    private let userProfileTableViewController = UITableViewController()
    
    // MARK: - UserProfileCoordinator Initializer
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - SubCoordinator Required Methods
    
    func start() {
        navigationController.pushViewController(userProfileTableViewController, animated: false)
    }
}


