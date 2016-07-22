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
    
}

// MARK: - BrowseMealsViewModelProtocol

protocol BrowseMealsViewModelProtocol: class {
    
    
    var resource: Resource<Meal> { get }
    
    weak var viewDelegate: BrowseMealsViewModelViewDelegate?               { get set }
    weak var coordinatorDelegate: BrowseMealsViewModelCoordinatorDelegate? { get set }
}

// MARK: - BrowseMealsViewModel

class BrowseMealsViewModel: BrowseMealsViewModelProtocol {
    
    let resource = Meal.Resource_
    
    var meal: Meal?
    
    weak var viewDelegate: BrowseMealsViewModelViewDelegate?
    weak var coordinatorDelegate: BrowseMealsViewModelCoordinatorDelegate?
    
    func startLoad() {
        resource.loadChildAdded { result in
            switch result {
            case .Failure(let error): self.viewDelegate?.anErrorHasOccured(error._domain) // TODO: fix error handling
            case .Success(let meal):  self.meal = meal
            }
        }
    }
    
    func imageLoad() {
        resource.loadImage { result in
            switch result {
            case .Failure(let error): self.viewDelegate?.anErrorHasOccured(error._domain) // TODO: fix error handling
            case .Success(let Image):  Image.dump_()
            }
        }
    }
    
}