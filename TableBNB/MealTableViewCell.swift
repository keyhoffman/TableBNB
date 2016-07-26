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
    func showChefDescriptionPopup(forChefID chefID: String)
}

// MARK: - MealTableViewCell

final class MealTableViewCell: UITableViewCell, Configurable {
    
    let showDescriptionButton = UIButton()
    let chefDisplayButton     = UIButton()
    
    // TODO: Add viewmodel to cell
    
    let descriptionLabel = UILabel() // make this an animated popover
    
    var meal: Meal?
    
    weak var cellDelegate: MealTableViewCellDelegate?
    
    // MARK: - MealTableViewCell Initializer
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        showDescriptionButton.addTarget(self, action: #selector(showMealDescriptionPopup), forControlEvents: .TouchUpInside)
        chefDisplayButton.addTarget(self, action: #selector(showChefDescriptionPopup), forControlEvents: .TouchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showChefDescriptionPopup() {
        guard let chefID = meal?.chefID else { return }
        cellDelegate?.showChefDescriptionPopup(forChefID: chefID)
    }
    
    func showMealDescriptionPopup() {
        guard let meal = meal else { return }
        cellDelegate?.showMealDescriptionPopup(forMeal: meal)
    }
    
    // MARK: - Configurable Required Methods
    
    func configure(withItem item: Meal) {
        defer { setNeedsLayout() }
        meal = item
        MealCellStyleSheet.prepare(self)
    }
    
}

