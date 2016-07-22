//
//  TabBarCoordinator.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import UIKit

// MARK: - TabBarCoordinatorDelegate Protocol

protocol TabBarCoordinatorDelegate: class {
    
}

// MARK: - TabBarCoordinator

final class TabBarCoordinator: SubCoordinator, BrowseMealsCoordinatorDelegate, AddMealCoordinatorDelegate, UserProfileCoordinatorDelegate {
    
    // MARK: - TabBarCoordinatorDelegate Declaration
    
    weak var coordinatorDelegate: TabBarCoordinatorDelegate?
    
    // MARK: - Root Property Declarations
    
    private let window: UIWindow
    private let rootViewController = UITabBarController()
    
    // MARK: - NavigationController Declarations
    
    private let addMealNavigationContoller     = TabBarStyleSheet.AddMeal.navigationController
    private let browseMealsNavigationContoller = TabBarStyleSheet.BrowseMeals.navigationController
    private let userProfileNavigationContoller = TabBarStyleSheet.UserProfile.navigationController
    
    // MARK: - Sub-Coordinator Declarations
    
    private let addMealCoordinator:     AddMealCoordinator
    private let browseMealsCoordinator: BrowseMealsCoordinator
    private let userProfileCoordinator: UserProfileCoordinator
    
    // MARK: - TabBarCoordinator Initializer
    
    init(window: UIWindow) {
        self.window = window
        
        let viewControllers = [addMealNavigationContoller, browseMealsNavigationContoller, userProfileNavigationContoller]
        
        rootViewController.setViewControllers(viewControllers, animated: false)
        
        addMealCoordinator     = AddMealCoordinator(navigationController: addMealNavigationContoller)
        browseMealsCoordinator = BrowseMealsCoordinator(navigationController: browseMealsNavigationContoller)
        userProfileCoordinator = UserProfileCoordinator(navigationController: userProfileNavigationContoller)
        
        addMealCoordinator.coordinatorDelegate     = self
        browseMealsCoordinator.coordinatorDelegate = self
        userProfileCoordinator.coordinatorDelegate = self
    }
    
    
    // MARK: - SubCoordinator Required Methods
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        addMealCoordinator.start()
        browseMealsCoordinator.start()
        userProfileCoordinator.start()
    }
}