//
//  MealTableViewCell.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import UIKit

// MARK: - MealTableViewCellDelegate Protocol

protocol MealTableViewCellDelegate: class {
    func showMealDescriptionPopup(forMeal meal: Meal)
    func showChefDescriptionPopup(forMeal meal: Meal)
}

// MARK: - MealTableViewCell

final class MealTableViewCell: UITableViewCell, Configurable {
    
    let showDescriptionButton = UIButton()
    let displayChefInfoButton = UIButton()
    
    let spinner = UIActivityIndicatorView()
    
    let mealImageView = UIImageView()
    
    var meal: Meal?
    
    weak var cellDelegate: MealTableViewCellDelegate?
    
    // MARK: - MealTableViewCell Initializer
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        spinner.startAnimating()
        
        showDescriptionButton.addTarget(self, action: #selector(showMealDescriptionPopup), forControlEvents: .TouchUpInside)
        displayChefInfoButton.addTarget(self, action: #selector(showChefDescriptionPopup), forControlEvents: .TouchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showChefDescriptionPopup() {
        guard let meal = meal else { return }
        cellDelegate?.showChefDescriptionPopup(forMeal: meal)
    }
    
    func showMealDescriptionPopup() {
        guard let meal = meal else { return }
        cellDelegate?.showMealDescriptionPopup(forMeal: meal)
    }
    
    // MARK: - Configurable Required Methods
    
    func configure(withItem item: Meal) {
        defer { setNeedsLayout() }
        meal = item
        spinner.stopAnimating()
        MealCellStyleSheet.prepare(self)
    }
    
}

