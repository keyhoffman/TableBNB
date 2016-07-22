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

protocol BrowseMealsViewModelViewDelegate: class {
    
}

// MARK: - BrowseMealsViewModelProtocol

protocol BrowseMealsViewModelProtocol: class {
    weak var viewDelegate: BrowseMealsViewModelViewDelegate? { get set }
    weak var coordinatorDelegate: BrowseMealsViewModelCoordinatorDelegate? { get set }
    var resource: Resource<Meal> { get }
}

// MARK: - BrowseMealsViewModel

class BrowseMealsViewModel: BrowseMealsViewModelProtocol {
    
    let resource = Meal.Resource_
    
    weak var viewDelegate: BrowseMealsViewModelViewDelegate?
    weak var coordinatorDelegate: BrowseMealsViewModelCoordinatorDelegate?
    
}