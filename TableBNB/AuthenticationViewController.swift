//
//  AuthenticationViewController.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/19/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - AuthenticationViewControllerDelegate Protocol

protocol AuthenticationViewControllerDelegate: class {
    func signUp(email email: String?, password: String?, username: String?, sender: AuthenticationViewController)
    func login(email email: String?, password: String?, sender: AuthenticationViewController)
    func navigateToLoginButtonPressed(sender: AuthenticationViewController)
}

// MARK: - AuthenticationViewController

final class AuthenticationViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - User TextField Inputs
    
    private var enteredEmail:    String?
    private var enteredPassword: String?
    private var enteredUsername: String?
    
    // MARK: - isSigningUp Declaration
    
    private let isSigningUp: Bool
    
    // MARK: - AuthenticationViewControllerDelegate Declaration
    
    weak var delegate: AuthenticationViewControllerDelegate?
    
    // MARK: - UIBarButtonItem Declaration
    
    private let navigateToLoginButton = UIBarButtonItem()
    
    // MARK: - TextField Declarations
    
    private let emailTextField    = AuthViewControllerStyleSheet.AuthTextField.Email.textField
    private let passwordTextField = AuthViewControllerStyleSheet.AuthTextField.Password.textField
    private let usernameTextField = AuthViewControllerStyleSheet.AuthTextField.Username.textField
    
    // MARK: - AuthenticationViewController Initializer
    
    init(isSigningUp: Bool) {
        self.isSigningUp = isSigningUp
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFields()
        setTitle()
        setNavigationItems()
        view.backgroundColor = AuthViewControllerStyleSheet.BackgroundColor
    }

    // MARK: - TextField Delegate Methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        if text.isEmpty { return false }
        switch textField {
        case emailTextField:
            enteredEmail = text
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            passwordTextField.hidden = false
        case passwordTextField:
            enteredPassword = text
            switch isSigningUp {
            case false: delegate?.login(email: enteredEmail, password: enteredPassword, sender: self)
            case true:
                passwordTextField.resignFirstResponder()
                usernameTextField.becomeFirstResponder()
                usernameTextField.hidden = false
            }
        case usernameTextField:
            enteredUsername = text
            delegate?.signUp(email: enteredEmail, password: enteredPassword, username: enteredUsername, sender: self)
        default: fatalError("Invalid textfield")
        }
        return true
    }
    
    // MARK: - Navigation Action Methods
    
    func navigateToLoginViewController(sender: UIBarButtonItem) {
        delegate?.navigateToLoginButtonPressed(self)
    }
    
    // MARK: - Set View Properties
    
    private func setNavigationItems() {
        if isSigningUp {
            navigateToLoginButton.target = self
            navigateToLoginButton.action = #selector(AuthenticationViewController.navigateToLoginViewController(_:))
            navigateToLoginButton.title  = AuthViewControllerStyleSheet.LoginTitle
            navigationItem.rightBarButtonItem = navigateToLoginButton
        }
    }


    private func setTextFields() {
        emailTextField.delegate    = self
        passwordTextField.delegate = self
        usernameTextField.delegate = self
        
        emailTextField.becomeFirstResponder()
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(usernameTextField)
        
        emailTextField.snp_makeConstraints { make in
            make.centerX.equalTo(view.snp_centerX)
            make.width.equalTo(view).multipliedBy(AuthViewControllerStyleSheet.AuthTextField.Frame.WidthToViewWidthFactor.value)
            make.height.equalTo(view).multipliedBy(AuthViewControllerStyleSheet.AuthTextField.Frame.HeightToViewHeightFactor.value)
            make.top.equalTo(view).offset(view.bounds.height * AuthViewControllerStyleSheet.AuthTextField.Frame.TopToViewTopFactor.value)
        }
        
        passwordTextField.snp_makeConstraints { make in
            make.width.equalTo(emailTextField)
            make.centerX.equalTo(emailTextField)
            make.top.equalTo(emailTextField.snp_bottom)
            make.height.equalTo(emailTextField)
        }
        
        usernameTextField.snp_makeConstraints { make in
            make.width.equalTo(emailTextField)
            make.centerX.equalTo(emailTextField)
            make.top.equalTo(passwordTextField.snp_bottom)
            make.height.equalTo(emailTextField)
            
        }

    }
    
    private func setTitle() {
        if isSigningUp {
            title = AuthViewControllerStyleSheet.SignUpTitle
        } else {
            title = AuthViewControllerStyleSheet.LoginTitle
        }
    }
}
