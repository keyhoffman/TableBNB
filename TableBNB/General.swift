//
//  General.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/19/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import UIKit

// TODO: Set a general theme for the app and set all of the view controller style elements to the them color

enum Theme {
    case Title, Body
    
    var font: UIFont {
        switch self {
        case Title: return UIFont(name: Font.HelveticaNeue.font, size: 16)!       // FIXME: optional
        case Body:  return UIFont(name: Font.HelveticaNeueLight.font, size: 14)!  // FIXME: optional
        }
    }
}

// MARK: - Color

enum Color {
    case White, Cyan, LightGray, Blue, Red, Black, DarkGray, WhiteGrayScale08
    
    var color: UIColor {
        switch self {
        case White:            return .whiteColor()
        case Cyan:             return .cyanColor()
        case LightGray:        return .lightGrayColor()
        case Blue:             return .blueColor()
        case Red:              return .redColor()
        case Black:            return .blackColor()
        case DarkGray:         return .darkGray()
        case WhiteGrayScale08: return .whiteGrayScale08()
        }
    }
}

// MARK: - Font

enum Font {
    case HelveticaNeue, HelveticaNeueLight, HelveticaNeueMedium
    
    var font: String {
        switch self {
        case HelveticaNeue:       return "HelveticaNeue"
        case HelveticaNeueLight:  return "HelveticaNeue-Light"
        case HelveticaNeueMedium: return "HelveticaNeue-Medium"
        }
    }
}