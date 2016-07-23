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
    
}

// MARK: - BrowseMealsViewModelViewDelegate

protocol BrowseMealsViewModelViewDelegate: class, ErrorDelegate {
    func appendMeal(meal: Meal)
}

protocol BrowseMealsViewModelCellDelegate: class {
    func setMealImage(image: UIImage)
}

// MARK: - BrowvarealsViewModelProtocol

protocol BrowseMealsViewModelProtocol: class {
    weak var viewDelegate: BrowseMealsViewModelViewDelegate?               { get set }
    weak var coordinatorDelegate: BrowseMealsViewModelCoordinatorDelegate? { get set }
}

// MARK: - BrowseMealsViewModel

final class BrowseMealsViewModel: BrowseMealsViewModelProtocol {

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
}