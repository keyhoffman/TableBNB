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
    
}

// MARK: - BrowseMealsViewModelViewDelegate

protocol BrowseMealsViewModelViewDelegate: class, ErrorDelegate {
    func appendMeal(meal: Meal)
}

// MARK: - BrowvarealsViewModelProtocol

protocol BrowseMealsViewModelProtocol: class {
    weak var viewDelegate: BrowseMealsViewModelViewDelegate?               { get set }
    weak var coordinatorDelegate: BrowseMealsViewModelCoordinatorDelegate? { get set }
}

// MARK: - BrowseMealsViewModel

class BrowseMealsViewModel: BrowseMealsViewModelProtocol {
    
    
    var meal: Meal? = nil

    weak var coordinatorDelegate: BrowseMealsViewModelCoordinatorDelegate?
    weak var viewDelegate: BrowseMealsViewModelViewDelegate? { didSet { startDatabaseLoad() } }
    
    
    private func startDatabaseLoad() {
        Meal.loadChildAdded { result in
            switch result {
            case .Failure(let error): self.viewDelegate?.anErrorHasOccured(error._domain) // TODO: fix error handling
            case .Success(let meal):  self.meal = meal
                                      self.viewDelegate?.appendMeal(meal)
            }
        }
    }
}