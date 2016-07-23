//
//  AuthViewControllerStyleSheet.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/19/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

// MARK: - AuthViewControllerStyleSheet

enum AuthViewControllerStyleSheet: ViewPreparer {
    
    static func prepare(subject: AuthenticationViewController) {
        subject.view.backgroundColor = AuthViewControllerStyleSheet.BackgroundColor
        
        subject.view.addSubview(subject.emailTextField)
        subject.view.addSubview(subject.passwordTextField)
        subject.view.addSubview(subject.usernameTextField)
        subject.view.addSubview(subject.errorLabel)
        
        subject.emailTextField.snp_makeConstraints { make in
            make.centerX.equalTo(subject.view.snp_centerX)
            make.width.equalTo(subject.view).multipliedBy(AuthViewControllerStyleSheet.TextField.Frame.WidthToViewWidthFactor.value)
            make.height.equalTo(subject.view).multipliedBy(AuthViewControllerStyleSheet.TextField.Frame.HeightToViewHeightFactor.value)
            make.top.equalTo(subject.view).offset(subject.view.bounds.height * AuthViewControllerStyleSheet.TextField.Frame.TopToViewTopFactor.value)
        }
        
        subject.passwordTextField.snp_makeConstraints { make in
            make.width.equalTo(subject.emailTextField)
            make.centerX.equalTo(subject.emailTextField)
            make.top.equalTo(subject.emailTextField.snp_bottom)
            make.height.equalTo(subject.emailTextField)
        }
        
        subject.usernameTextField.snp_makeConstraints { make in
            make.width.equalTo(subject.emailTextField)
            make.centerX.equalTo(subject.emailTextField)
            make.top.equalTo(subject.passwordTextField.snp_bottom)
            make.height.equalTo(subject.emailTextField)
        }
        
        subject.errorLabel.snp_makeConstraints { make in
            make.centerX.width.equalTo(subject.emailTextField)
            make.bottom.equalTo(subject.emailTextField.snp_top).offset(AuthViewControllerStyleSheet.Label.Frame.BottomToEmailTextFieldToOffset.value)
            make.height.equalTo(AuthViewControllerStyleSheet.Label.Frame.Height.value)
        }

    }
    
    static var BackgroundColor: UIColor { return Color.Red.color }
    
    static var SignUpTitle: String { return "Sign Up" }
    static var LoginTitle:  String { return "Login" }
    
    // MARK: - AuthTextField
    
    enum TextField {
        case Email, Password, Username
        
        var textField: UITextField {
            let tf = UITextField()
            tf.defaultSettings()
            tf.placeholder     = placeholder
            tf.backgroundColor = backgroundColor
            tf.secureTextEntry = secureTextEntry
            tf.hidden          = hidden
            return tf
        }
        
        private var placeholder: String {
            switch self {
            case Email:    return "Enter your email"
            case Password: return "Enter your password"
            case Username: return "Enter your username"
            }
        }
        
        private var backgroundColor: UIColor {
            switch self {
            case Email:    return Color.Blue.color
            case Password: return Color.LightGray.color
            case Username: return Color.Cyan.color
            }
        }
        
        private var secureTextEntry: Bool {
            switch self {
            case Email:    return false
            case Password: return true
            case Username: return false
            }
        }
        
        private var hidden: Bool {
            switch self {
            case Email:    return false
            case Password: return true
            case Username: return true
            }
        }
        
        // MARK: - AuthTextField Frame
        
        enum Frame {
            case WidthToViewWidthFactor, HeightToViewHeightFactor, TopToViewTopFactor
            
            var value: CGFloat {
                switch self {
                case WidthToViewWidthFactor:   return 0.80
                case HeightToViewHeightFactor: return 0.05
                case TopToViewTopFactor:       return 0.20
                }
            }
            
        }
    }
    
    // MARK: - BarButtonItem
    
    enum BarButtonItem {
        case NavigateToLogin
        
        var barButtonItem: UIBarButtonItem {
            let b = UIBarButtonItem()
            b.title = "Login"
            return b
        }
    }
    
    // MARK: - ErrorLabel
    
    enum Label {
        case Error
        
        var label: UILabel {
            let l = UILabel()
            l.hidden          = true
            l.backgroundColor = Color.White.color
            l.textColor       = Color.Red.color
            l.textAlignment   = .Center
            return l
        }
        
        // MARK: - ErrorLabel Frame
        
        enum Frame {
            case Height, BottomToEmailTextFieldToOffset
            
            var value: CGFloat {
                switch self {
                case Height:                         return 30
                case BottomToEmailTextFieldToOffset: return -10
                }
            }
        }
    }
}

enum AuthViewModelStyleSheet {
    static var ValidPasswordCharacterCount: Int { return 5 }
    static var ValidUsernameCharacterCount: Int { return 5 }
    
    static var ValidEmailPredicateArguments: String { return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,32}" }
    static var ValidEmailPredicateFormat:    String { return "SELF MATCHES %@" }
}






