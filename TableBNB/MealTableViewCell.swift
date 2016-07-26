//
//  MealTableViewCell.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import UIKit
import PopupDialog

// MARK: - MealTableViewCell

final class MealTableViewCell: UITableViewCell, Configurable {
    
    let showDescriptionButton = UIButton()
    
    let descriptionLabel = UILabel() // make this an animated popover
    
    var meal: Meal?
    
    // MARK: - MealTableViewCell Initializer
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        showDescriptionButton.addTarget(self, action: #selector(showDescription), forControlEvents: .TouchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showDescription() {
        descriptionLabel.hidden = false
    }
    
    func showPopup() {
        let popup = PopupDialog(title: meal?.name, message: meal?.description)
    }
    
    // MARK: - Configurable Required Methods
    
    func configure(withItem item: Meal) {
        defer { setNeedsLayout() }
        meal = item
        MealCellStyleSheet.prepare(self)
    }
    
}

