//
//  AuthViewControllerStyleSheet.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/19/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import UIKit

// MARK: - AuthViewControllerStyleSheet

enum AuthViewControllerStyleSheet {
    
    static var BackgroundColor: UIColor { return Color.Red.color }
    
    static var SignUpTitle: String { return "Sign Up" }
    static var LoginTitle:  String { return "Login" }
    
    // MARK: - AuthTextField
    
    enum AuthTextField {
        case Email, Password, Username
        
        var textField: UITextField {
            let tf = UITextField()
            tf.defaultSettings()
            tf.placeholder = placeholder
            tf.backgroundColor = backgroundColor
            tf.secureTextEntry = secureTextEntry
            tf.hidden = hidden
            return tf
        }
        
        private var placeholder: String {
            switch self {
            case .Email:    return "Enter your email"
            case .Password: return "Enter your password"
            case .Username: return "Enter your username"
            }
        }
        
        private var backgroundColor: UIColor {
            switch self {
            case .Email:    return Color.Blue.color
            case .Password: return Color.LightGray.color
            case .Username: return Color.Cyan.color
            }
        }
        
        private var secureTextEntry: Bool {
            switch self {
            case .Email:    return false
            case .Password: return true
            case .Username: return false
            }
        }
        
        private var hidden: Bool {
            switch self {
            case .Email:    return false
            case .Password: return true
            case .Username: return true
            }
        }
        
        enum Frame {
            case WidthToViewWidthFactor, HeightToViewHeightFactor, TopToViewTopFactor
            
            var value: CGFloat {
                switch self {
                case .WidthToViewWidthFactor:   return 0.80
                case .HeightToViewHeightFactor: return 0.05
                case .TopToViewTopFactor:       return 0.20
                }
            }
            
        }
    }

}

// MARK: - UITextField Extension

extension UITextField { // TODO: - Move away from style sheet
    func clearText() {
        self.text = ""
    }
    
    func defaultSettings() {
        self.adjustsFontSizeToFitWidth = true
        self.autocapitalizationType    = .None
        self.autocorrectionType        = .No
        self.clearButtonMode           = .Always
        self.keyboardAppearance        = .Dark
        self.keyboardType              = .Default
    }
}