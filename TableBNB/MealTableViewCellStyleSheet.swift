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

enum MealCellStyleSheet: ViewPreparer {
    case MealImage, CostLabel
    
    static func prepare(subject: MealTableViewCell) {
        subject.backgroundColor = Color.LightGray.color
        
        subject.spinner.activityIndicatorViewStyle                = .White
        subject.spinner.hidesWhenStopped                          = true
        subject.spinner.translatesAutoresizingMaskIntoConstraints = false
        
        subject.mealNamelabel.textColor       = Color.White.color
        subject.mealNamelabel.textAlignment   = .Center
        subject.mealNamelabel.backgroundColor = Color.Blue.color
        
        
        subject.mealCostLabel.textColor       = Color.White.color
        subject.mealCostLabel.textAlignment   = .Center
        subject.mealCostLabel.backgroundColor = Color.Black.color
        
        subject.mealFeedsLabel.textColor       = Color.White.color
        subject.mealFeedsLabel.textAlignment   = .Center
        subject.mealFeedsLabel.backgroundColor = Color.Black.color
        
        
        //add the view you want at the bottom first, and the one you want on top last
        subject.addSubview(subject.spinner)
        subject.addSubview(subject.mealImageView)
        subject.addSubview(subject.mealCostLabel)
        subject.addSubview(subject.mealNamelabel)
        subject.addSubview(subject.mealFeedsLabel)
        
        subject.mealImageView.snp_makeConstraints { make in
            make.width.equalTo(subject.snp_width)
            make.height.equalTo(subject.snp_height).multipliedBy(self.MealImage.heightToCellHeightFactor)
            make.top.equalTo(subject.snp_top)
        }
        
        subject.spinner.snp_makeConstraints { make in
            make.center.equalTo(subject.mealImageView.snp_center)
        }
        
        subject.mealNamelabel.snp_makeConstraints { make in
            make.bottom.equalTo(subject.snp_bottom)
            make.top.equalTo(subject.mealImageView.snp_bottom)
            make.width.equalTo(subject.snp_width)
        }
        
        subject.mealCostLabel.snp_makeConstraints { make in
            make.top.equalTo(subject.mealImageView.snp_top)
            make.height.equalTo(subject.mealImageView.snp_height).multipliedBy(self.CostLabel.heightToCellHeightFactor)
            make.left.equalTo(subject.snp_left)
            make.width.equalTo(subject.snp_width).multipliedBy(self.CostLabel.widthToCellWidthFactor)
        }
        
        subject.mealFeedsLabel.snp_makeConstraints { make in
            make.height.equalTo(subject.mealCostLabel.snp_height)
            make.width.equalTo(subject.mealCostLabel.snp_width)
            make.left.equalTo(subject.mealCostLabel.snp_left)
            make.top.equalTo(subject.mealCostLabel.snp_bottom)
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