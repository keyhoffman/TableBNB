//
//  BrowseMealsCoordinator.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog

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
    
    private let browseMealsViewModel: BrowseMealsViewModelType
    
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
    
    // MARK: - BrowseMealsViewModelCoordinatorDelegate Required Methodes
    
    func showChefDescriptionPopup(forUser user: User) {
        let message = "Rating: " + String(user.rating) + "/" + String(User.MaxRating)
        let chefInfoPopup = PopupDialog(title: user.username, message: message) // TODO: Move this to stylesheet
        ChefInformationStyleSheet.prepare(chefInfoPopup)
        browseMealsTableViewController.presentViewController(chefInfoPopup, animated: true, completion: nil)
    }
    
    func showMealDescriptionPopup(forMeal meal: Meal) {
        let description = "Message from the chef:\n" + meal.description
        let ingredients = "Active ingredients: \n" + meal.ingredients
        let message = description + "\n\n" + ingredients
        let descriptionPopup = PopupDialog(title: meal.name, message: message)
        MealDescriptionStyleSheet.prepare(descriptionPopup)
        browseMealsTableViewController.presentViewController(descriptionPopup, animated: true, completion: nil)
    }
    
    func userDidSelectMeal(meal: Meal) {
        meal.dump_(withContext: "userDidSelectMeal")
    }
}























