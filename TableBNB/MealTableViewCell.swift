//
//  MealTableViewCell.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import UIKit

//MARK: - MealTableViewCell

final class MealTableViewCell: UITableViewCell, Configurable {

    //MARK: - MealTableViewCell Initializer
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // TODO: Move all view logic to here
        
        MealCellStyleSheet.prepare(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurable Required Methods
    // TODO:   Move all data logic to here
    func configure(withItem item: Meal) {
        
    }
    
}

//// MARK: - MealTableViewCell Extension
//
//struct ViewData {
//    let name:           String
//    let pricePerPerson: Double
//    let feeds:          Int
//}
//
//var viewData: ViewData? {
//didSet {
//    textLabel?.text       = viewData?.name
//    detailTextLabel?.text = String(viewData?.pricePerPerson)
//}
//}
//
//
//extension MealTableViewCell.ViewData {
//    init(meal: Meal) {
//        self.name           = meal.name
//        self.pricePerPerson = meal.pricePerPerson
//        self.feeds          = meal.feeds
//    }
//}
