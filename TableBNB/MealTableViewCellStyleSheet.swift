//
//  MealTableViewCellStyleSheet.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/22/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

// MARK: - MealCellStyleSheet

enum MealCellStyleSheet: ViewPreparer {
    case MealImage, CostLabel
    
    static func prepare(subject: MealTableViewCell) {
        
        subject.backgroundColor = Color.Red.color
        
        let mealNamelabel  = UILabel()
        let mealCostLabel  = UILabel()
        let mealFeedsLabel = UILabel()
        let errorLabel     = UILabel()
        
        let mealImageView = UIImageView()
        
        let spinner = UIActivityIndicatorView()
        
        spinner.activityIndicatorViewStyle                = .White
        spinner.hidesWhenStopped                          = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        
        mealNamelabel.textColor       = Color.White.color
        mealNamelabel.textAlignment   = .Center
        mealNamelabel.backgroundColor = Color.Blue.color
        
        mealCostLabel.textColor       = Color.White.color
        mealCostLabel.textAlignment   = .Center
        mealCostLabel.backgroundColor = Color.Black.color
        
        mealFeedsLabel.textColor       = Color.White.color
        mealFeedsLabel.textAlignment   = .Center
        mealFeedsLabel.backgroundColor = Color.Black.color
        
        errorLabel.textColor       = Color.Red.color
        errorLabel.textAlignment   = .Center
        errorLabel.backgroundColor = Color.White.color
        errorLabel.hidden          = true
        
        subject.descriptionLabel.textColor       = Color.Red.color
        subject.descriptionLabel.textAlignment   = .Center
        subject.descriptionLabel.backgroundColor = Color.White.color
        subject.descriptionLabel.hidden          = true
        
        subject.showDescriptionButton.setTitle("show", forState: .Normal)
        subject.showDescriptionButton.setTitleColor(Color.Cyan.color, forState: .Normal)
        
        mealNamelabel.text  = subject.meal?.name ?? "Could not load meal name"
        mealCostLabel.text  = "$" + String(subject.meal?.pricePerPerson ?? 0) + "/guest"
        mealFeedsLabel.text = "\(subject.meal?.feeds ?? 0) guests welcome"
        
        subject.descriptionLabel.text = subject.meal?.description ?? "no description added"
        
        subject.meal?.loadImage { result in
            performUpdatesOnMainThread {
                switch result {
                case .Failure(let error): errorLabel.text   = error._domain
                                          errorLabel.hidden = false
                case .Success(let image): spinner.stopAnimating()
                                          mealImageView.image = image
                }
            }
        }

        subject.addSubview(mealImageView)
        subject.addSubview(mealCostLabel)
        subject.addSubview(mealNamelabel)
        subject.addSubview(mealFeedsLabel)
        subject.addSubview(subject.descriptionLabel)
        subject.addSubview(subject.showDescriptionButton)
        subject.addSubview(errorLabel)
        subject.addSubview(spinner)
        
        mealImageView.snp_makeConstraints { make in
            make.width.equalTo(subject.snp_width)
            make.height.equalTo(subject.snp_height).multipliedBy(self.MealImage.heightToCellHeightFactor)
            make.top.equalTo(subject.snp_top)
        }
        
        spinner.snp_makeConstraints { make in
            make.center.equalTo(mealImageView.snp_center)
        }
        
        mealNamelabel.snp_makeConstraints { make in
            make.bottom.equalTo(subject.snp_bottom)
            make.top.equalTo(mealImageView.snp_bottom)
            make.width.equalTo(subject.snp_width)
        }
        
        mealCostLabel.snp_makeConstraints { make in
            make.top.equalTo(mealImageView.snp_top)
            make.height.equalTo(mealImageView.snp_height).multipliedBy(self.CostLabel.heightToCellHeightFactor)
            make.left.equalTo(subject.snp_left)
            make.width.equalTo(subject.snp_width).multipliedBy(self.CostLabel.widthToCellWidthFactor)
        }
        
        mealFeedsLabel.snp_makeConstraints { make in
            make.height.equalTo(mealCostLabel.snp_height)
            make.width.equalTo(mealCostLabel.snp_width)
            make.left.equalTo(mealCostLabel.snp_left)
            make.top.equalTo(mealCostLabel.snp_bottom)
        }
        
        subject.descriptionLabel.snp_makeConstraints { make in
            make.edges.equalTo(mealImageView).inset(60)
        }
        
        subject.showDescriptionButton.snp_makeConstraints { make in
            make.height.width.equalTo(50)
            make.top.equalTo(mealImageView.snp_top)
            make.right.equalTo(mealImageView.snp_right)
        }
        
        errorLabel.snp_makeConstraints { make in
            make.edges.equalTo(mealImageView)
        }
    }
    
    
    private var heightToCellHeightFactor: CGFloat {
        switch self {
        case MealImage: return 0.75
        case CostLabel: return 0.3
        }
    }
    
    private var widthToCellWidthFactor: CGFloat {
        switch self {
        case MealImage: return 1.0
        case CostLabel: return 0.3
        }
    }
}