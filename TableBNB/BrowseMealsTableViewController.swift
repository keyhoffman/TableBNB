//
//  BrowseMealsTableViewController.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import UIKit

// MARK: - BrowseMealsTableViewController

final class BrowseMealsTableViewController: TableViewController<Meal, MealTableViewCell>, BrowseMealsViewModelViewDelegate {
    
    weak var viewModel: BrowseMealsViewModelProtocol? {
        didSet { viewModel?.viewDelegate = self }
    }
    
    // MARK: - BrowseMealsTableViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = BrowseMealsStyleSheet.title
    }
}