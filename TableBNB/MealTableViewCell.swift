//
//  MealTableViewCell.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import UIKit

// MARK: - MealTableViewCell

final class MealTableViewCell: UITableViewCell, Configurable {
    
    let mealNamelabel  = UILabel()
    let mealCostLabel  = UILabel()
    let mealFeedsLabel = UILabel()
    
    let mealImageView = UIImageView()
    
    let spinner = UIActivityIndicatorView()

    // MARK: - MealTableViewCell Initializer
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        spinner.startAnimating()
        MealCellStyleSheet.prepare(self)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurable Required Methods
    
    func configure(withItem item: Meal) {
        defer { setNeedsLayout() }
        mealNamelabel.text  = item.name
        mealCostLabel.text  = "$\(item.pricePerPerson)/Guest" // TODO: - This needs to be formatted in the viewmodel
        mealFeedsLabel.text = "\(item.feeds) guests welcome"
        item.loadImage { result in
            performUpdatesOnMainThread {
                switch result {
                case .Failure(let error): self.mealNamelabel.text = error._domain
                case .Success(let image): self.spinner.stopAnimating()
                                          self.mealImageView.image = image
                }
            }
        }
    }
    
}

