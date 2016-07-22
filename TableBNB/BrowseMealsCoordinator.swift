//
//  BrowseMealsCoordinator.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import UIKit

// MARK: - BrowseMealsCoordinatorDelegate Protocol

protocol BrowseMealsCoordinatorDelegate: class {
    
}

// MARK: - BrowseMealsCoordinator

final class BrowseMealsCoordinator: SubCoordinator, BrowseMealsViewModelCoordinatorDelegate {
    
    // MARK: - BrowseMealsCoordinatorDelegate Declaration
    
    weak var coordinatorDelegate: BrowseMealsCoordinatorDelegate?
    
    // MARK: - NavigationController Declaration
    
    private let navigationController: UINavigationController
    
    // MARK: - TableViewController Declaration
    
    private let browseMealsTableViewController: BrowseMealsTableViewController
    
    // MARK: - TableViewModel Declaration
    
    private let browseMealsViewModel: BrowseMealsViewModelProtocol
    
    // MARK: - TableModel Declaration
    
    // MARK: - BrowseMealsCoordinator Initializer
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        browseMealsTableViewController = BrowseMealsTableViewController()
        
        browseMealsViewModel = BrowseMealsViewModel()
        
        browseMealsTableViewController.viewModel = browseMealsViewModel
        browseMealsViewModel.coordinatorDelegate = self
        
        
    }
    
    // MARK: - SubCoordinator Required Methods
    
    func start() {
        navigationController.pushViewController(browseMealsTableViewController, animated: false)
    }
}