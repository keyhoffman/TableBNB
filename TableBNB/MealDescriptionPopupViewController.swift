//
//  MealDescriptionPopupViewController.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/26/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import UIKit
import PopupDialog

class MealDescriptionViewController: UIViewController {
    
    let popupVC =  PopupDialogDefaultViewController()
    
    let meal: Meal
    
    init(meal: Meal) {
        self.meal = meal
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        popupVC.titleText = meal.name
        popupVC.messageText = meal.description
        
        self.presentViewController(popupVC, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
