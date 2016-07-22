//
//  MealTableViewCell.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import UIKit

final class MealTableViewCell: UITableViewCell, Configurable {

    struct ViewData {
        let name:           String
        let pricePerPerson: Double
        let feeds:          Int
    }
    
    var viewData: ViewData? {
        didSet {
            textLabel?.text       = viewData?.name
            detailTextLabel?.text = String(viewData?.pricePerPerson)
        }
    }
    
    // MARK: - Configurable Required Methods
    
    func configure(withItem item: Any) {
        
    }
    
}

// MARK: - MealTableViewCell Extension

extension MealTableViewCell.ViewData {
    init(meal: Meal) {
        self.name           = meal.name
        self.pricePerPerson = meal.pricePerPerson
        self.feeds          = meal.feeds
    }
}
