//
//  MealTableViewCell.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import UIKit

protocol MealTableViewCellDelegate: class {
    func showDescriptionPopup(forMeal meal: Meal)
}

// MARK: - MealTableViewCell

final class MealTableViewCell: UITableViewCell, Configurable {
    
    let showDescriptionButton = UIButton()
    let chefDisplayButton     = UIButton()
    
    let descriptionLabel = UILabel() // make this an animated popover
    
    var meal: Meal?
    
    weak var cellDelegate: MealTableViewCellDelegate?
    
    // MARK: - MealTableViewCell Initializer
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        showDescriptionButton.addTarget(self, action: #selector(showPopup), forControlEvents: .TouchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showDescription() {
        descriptionLabel.hidden = false
    }
    
    func showPopup() {
        guard let meal = meal else { return }
        cellDelegate?.showDescriptionPopup(forMeal: meal)
    }
    
    // MARK: - Configurable Required Methods
    
    func configure(withItem item: Meal) {
        defer { setNeedsLayout() }
        meal = item
        MealCellStyleSheet.prepare(self)
    }
    
}

