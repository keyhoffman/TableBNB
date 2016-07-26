//
//  BrowseMealsViewModel.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import UIKit

// MARK: - BrowseMealsViewModelCoordinatorDelegate

protocol BrowseMealsViewModelCoordinatorDelegate: class {
    func userDidSelectMeal(meal: Meal)
    func showMealDescriptionPopup(forMeal meal: Meal)
    func showChefDescriptionPopup(forUser user: User)
}

// MARK: - BrowseMealsViewModelViewDelegate

protocol BrowseMealsViewModelViewDelegate: class, ErrorDelegate {
    func appendMeal(meal: Meal)
    func appendMealImage(image: UIImage)
}

// MARK: - BrowvarealsViewModelProtocol

protocol BrowseMealsViewModelType: class {
    weak var viewDelegate:        BrowseMealsViewModelViewDelegate?        { get set }
    weak var coordinatorDelegate: BrowseMealsViewModelCoordinatorDelegate? { get set }
    
    func userDidSelectMeal(meal: Meal)
    func showMealDescriptionPopup(forMeal meal: Meal)
    func showChefDescriptionPopup(forMeal meal: Meal)
    
}

// MARK: - BrowseMealsViewModel

final class BrowseMealsViewModel: BrowseMealsViewModelType {

    weak var coordinatorDelegate: BrowseMealsViewModelCoordinatorDelegate?
    weak var viewDelegate: BrowseMealsViewModelViewDelegate? { didSet { beginLoading() } }
    
    func userDidSelectMeal(meal: Meal) {
        coordinatorDelegate?.userDidSelectMeal(meal)
    }
    
    func showMealDescriptionPopup(forMeal meal: Meal) {
        coordinatorDelegate?.showMealDescriptionPopup(forMeal: meal)
    }
    
    func showChefDescriptionPopup(forMeal meal: Meal) {
        Meal.loadValue(withKey: meal.chefID, forType: User.self) { result in
            performUpdatesOnMainThread {
                switch result {
                case .Failure(let error): self.viewDelegate?.anErrorHasOccured(error._domain) // TODO: fix error handling
                case .Success(let user):  self.coordinatorDelegate?.showChefDescriptionPopup(forUser: user)
                }
            }
        }
    }
    
    private func beginLoading() {
        Meal.loadChildAdded { result in
            switch result {
            case .Failure(let error): self.viewDelegate?.anErrorHasOccured(error._domain) // TODO: fix error handling
            case .Success(let meal):  self.loadImage(forMeal: meal)
            }
        }
    }
    
    private func loadImage(forMeal meal: Meal) {
        meal.loadImage { result in
            performUpdatesOnMainThread {
                switch result {
                case .Failure(let error): self.viewDelegate?.anErrorHasOccured(error._domain) // TODO: fix error handling
                case .Success(let image): self.viewDelegate?.appendMeal(meal)
                                          self.viewDelegate?.appendMealImage(image)
                }
            }
        }
    }

}





