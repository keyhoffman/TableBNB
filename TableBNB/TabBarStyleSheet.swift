//
//  TabBarStyleSheet.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import UIKit

enum TabBarStyleSheet {
    case AddMeal, BrowseMeals, UserProfile
    
    var navigationController: UINavigationController {
        let nav = UINavigationController()
        nav.tabBarItem = tabBarItem
        return nav
    }
    
    private var tabBarItem: UITabBarItem {
        let t = UITabBarItem()
        t.title = title
        t.image = image
        t.tag = tag
        return t
    }
    
    private var title: String {
        switch self {
        case AddMeal:     return "Add Meal"
        case BrowseMeals: return "Browse Meals"
        case UserProfile: return "Profile"
        }
    }
    
    private var image: UIImage? {
        switch self {
        case AddMeal:     return nil
        case BrowseMeals: return nil
        case UserProfile: return nil
        }
    }
    
    private var tag: Int {
        switch self {
        case AddMeal:     return 0
        case BrowseMeals: return 1
        case UserProfile: return 2
        }
    }

    
}