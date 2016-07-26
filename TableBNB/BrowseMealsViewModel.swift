//
//  BrowseMealsViewModel.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - BrowseMealsViewModelCoordinatorDelegate

protocol BrowseMealsViewModelCoordinatorDelegate: class {
    func userDidSelectMeal(meal: Meal)
    func showDescriptionPopup(forMeal meal: Meal)
}

// MARK: - BrowseMealsViewModelViewDelegate

protocol BrowseMealsViewModelViewDelegate: class, ErrorDelegate {
    func appendMeal(meal: Meal)
}

// MARK: - BrowvarealsViewModelProtocol

protocol BrowseMealsViewModelType: class {
    weak var viewDelegate: BrowseMealsViewModelViewDelegate?               { get set }
    weak var coordinatorDelegate: BrowseMealsViewModelCoordinatorDelegate? { get set }
    
    func userDidSelectMeal(meal: Meal)
    func showDescriptionPopup(forMeal meal: Meal)
    
}

// MARK: - BrowseMealsViewModel

final class BrowseMealsViewModel: BrowseMealsViewModelType {

    weak var coordinatorDelegate: BrowseMealsViewModelCoordinatorDelegate?
    weak var viewDelegate: BrowseMealsViewModelViewDelegate? { didSet { beginLoading() } }
    
    private func beginLoading() {
        Meal.loadChildAdded { result in
            performUpdatesOnMainThread {
                switch result {
                case .Failure(let error): self.viewDelegate?.anErrorHasOccured(error._domain) // TODO: fix error handling
                case .Success(let meal):  self.viewDelegate?.appendMeal(meal)
                }
            }
        }
    }
    
    func userDidSelectMeal(meal: Meal) {
        coordinatorDelegate?.userDidSelectMeal(meal)
    }
    
    func showDescriptionPopup(forMeal meal: Meal) {
        coordinatorDelegate?.showDescriptionPopup(forMeal: meal)
    }
}