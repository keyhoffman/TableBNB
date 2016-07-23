//
//  BrowseMealsTableViewControllerStyleSheet.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import UIKit

enum BrowseMealsStyleSheet: ViewPreparer {

    static func prepare(subject: BrowseMealsTableViewController) {
        subject.title = "Browse Meals"
        subject.tableView.allowsSelection = false
        subject.tableView.rowHeight = 300
    }
}