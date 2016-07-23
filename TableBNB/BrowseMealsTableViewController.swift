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

final class BrowseMealsTableViewController: TableViewController<MealTableViewCell>, BrowseMealsViewModelViewDelegate {
    
    weak var viewModel: BrowseMealsViewModelProtocol? {
        didSet { viewModel?.viewDelegate = self }
    }
    
    // MARK: - BrowseMealsTableViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BrowseMealsStyleSheet.prepare(self)
    }
    
    // MARK: - BrowseMealsViewModelViewDelegate Required Methods
    
    func appendMeal(meal: Meal) {
        self.data.append(meal)
    }
    
    func anErrorHasOccured(errorMessage: String) {
        title = title ?? String.emptyString() + errorMessage
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
}