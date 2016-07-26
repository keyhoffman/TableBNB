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
        
        subject.spinner.activityIndicatorViewStyle                = .White
        subject.spinner.hidesWhenStopped                          = true
        subject.spinner.translatesAutoresizingMaskIntoConstraints = false
        
        mealNamelabel.textColor       = Color.White.color
        mealNamelabel.textAlignment   = .Center
        mealNamelabel.backgroundColor = Color.Blue.color
        
        mealCostLabel.textColor       = Color.White.color
        mealCostLabel.textAlignment   = .Center
        mealCostLabel.backgroundColor = Color.Black.color
        
        mealFeedsLabel.textColor       = Color.White.color
        mealFeedsLabel.textAlignment   = .Center
        mealFeedsLabel.backgroundColor = Color.Black.color
        mealFeedsLabel.sizeToFit()
        
        subject.showDescriptionButton.setTitle("Meal", forState: .Normal)
        subject.showDescriptionButton.setTitleColor(Color.Cyan.color, forState: .Normal)
        subject.showDescriptionButton.backgroundColor = Color.Black.color
        
        subject.displayChefInfoButton.setTitle("Chef", forState: .Normal)
        subject.displayChefInfoButton.setTitleColor(Color.Cyan.color, forState: .Normal)
        subject.displayChefInfoButton.backgroundColor = Color.Black.color
        
        mealNamelabel.text  = subject.meal?.name ?? "Could not load meal name"
        mealCostLabel.text  = "$" + String(subject.meal?.pricePerPerson ?? 0) + "/guest"
        mealFeedsLabel.text = "\(subject.meal?.feeds ?? 0) guests welcome"
        
        subject.addSubview(subject.mealImageView)
        subject.addSubview(mealCostLabel)
        subject.addSubview(mealNamelabel)
        subject.addSubview(mealFeedsLabel)
        subject.addSubview(subject.showDescriptionButton)
        subject.addSubview(subject.displayChefInfoButton)
        subject.addSubview(subject.spinner)
        
        subject.mealImageView.snp_makeConstraints { make in
            make.width.equalTo(subject.snp_width)
            make.height.equalTo(subject.snp_height).multipliedBy(self.MealImage.heightToCellHeightFactor)
            make.top.equalTo(subject.snp_top)
        }
        
        subject.spinner.snp_makeConstraints { make in
            make.center.equalTo(subject.mealImageView.snp_center)
        }
        
        mealNamelabel.snp_makeConstraints { make in
            make.bottom.equalTo(subject.snp_bottom)
            make.top.equalTo(subject.mealImageView.snp_bottom)
            make.width.equalTo(subject.snp_width)
        }
        
        mealCostLabel.snp_makeConstraints { make in
            make.top.equalTo(subject.mealImageView.snp_top)
            make.height.equalTo(subject.mealImageView.snp_height).multipliedBy(self.CostLabel.heightToCellHeightFactor)
            make.left.equalTo(subject.snp_left)
            make.width.equalTo(subject.snp_width).multipliedBy(self.CostLabel.widthToCellWidthFactor)
        }
        
        mealFeedsLabel.snp_makeConstraints { make in
            make.height.equalTo(mealCostLabel.snp_height)
            make.left.equalTo(mealCostLabel.snp_left)
            make.top.equalTo(mealCostLabel.snp_bottom)
        }
        
        subject.showDescriptionButton.snp_makeConstraints { make in
            make.height.width.equalTo(50)
            make.top.equalTo(subject.mealImageView.snp_top)
            make.right.equalTo(subject.mealImageView.snp_right)
        }
        
        subject.displayChefInfoButton.snp_makeConstraints { make in
            make.height.width.equalTo(50)
            make.right.equalTo(subject.mealImageView.snp_right)
            make.bottom.equalTo(subject.mealImageView.snp_bottom)
        }
        
    }
    
    
    private var heightToCellHeightFactor: CGFloat {
        switch self {
        case MealImage: return 0.75
        case CostLabel: return 0.15
        }
    }
    
    private var widthToCellWidthFactor: CGFloat {
        switch self {
        case MealImage: return 1.0
        case CostLabel: return 0.3
        }
    }
}