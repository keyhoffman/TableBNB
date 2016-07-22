//
//  AuthenticationViewController.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/19/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - AuthenticationViewController

final class AuthenticationViewController: UIViewController, UITextFieldDelegate, AuthenticationViewModelViewDelegate {
    
    // MARK: - AuthenticationViewModelProtocol Declaration
    
    weak var viewModel: AuthenticationViewModelProtocol? {
        didSet { viewModel?.viewDelegate = self }
    }
    
    // MARK: - UIBarButtonItem Declaration
    
    private let navigateToLoginButton = AuthViewControllerStyleSheet.BarButtonItem.NavigateToLogin.barButtonItem
    
    // MARK: - TextField Declarations
    
    private let emailTextField    = AuthViewControllerStyleSheet.TextField.Email.textField
    private let passwordTextField = AuthViewControllerStyleSheet.TextField.Password.textField
    private let usernameTextField = AuthViewControllerStyleSheet.TextField.Username.textField
    
    // MARK: - ErrorLabel Declaration
    
    private let errorLabel: UILabel = AuthViewControllerStyleSheet.Label.Error.label
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldsAndErrorLabel()
        view.backgroundColor = AuthViewControllerStyleSheet.BackgroundColor
    }

    // MARK: - TextField Delegate Methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        if text.isEmpty { return false }
        switch textField {
        case emailTextField:    viewModel?.email    = text
        case passwordTextField: viewModel?.password = text
        case usernameTextField: viewModel?.username = text
        default: fatalError("Invalid textfield")
        }
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        errorLabel.hidden = true
    }
    
    // MARK: - AuthenticationViewModelViewDelegate Methods
    
    func emailIsValid(sender: AuthenticationViewModel) {
        emailTextField.resignFirstResponder()
        passwordTextField.becomeFirstResponder()
        passwordTextField.hidden = false
    }
    
    func passwordIsValid(sender: AuthenticationViewModel) {
        passwordTextField.resignFirstResponder()
        usernameTextField.becomeFirstResponder()
        usernameTextField.hidden = false
    }
    
    func anErrorHasOccured(errorMessage: String, sender: AuthenticationViewModel) {
        errorLabel.text   = errorMessage
        errorLabel.hidden = false
    }
    
    // MARK: - Set View Properties
    
    func setLoginNavigationItem(sender: AuthenticationViewModel) {
        navigateToLoginButton.target = self
        navigateToLoginButton.action = #selector(navigateToLoginButtonPressed)
        navigationItem.rightBarButtonItem = navigateToLoginButton
    }
    
    func navigateToLoginButtonPressed() {
        viewModel?.navigateToLoginButtonPressed()
    }
    
    func setTitle(title: String, sender: AuthenticationViewModel) {
        self.title = title
    }

    private func setTextFieldsAndErrorLabel() {
        emailTextField.delegate    = self
        passwordTextField.delegate = self
        usernameTextField.delegate = self
        
        emailTextField.becomeFirstResponder()
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(usernameTextField)
        view.addSubview(errorLabel)
        
        emailTextField.snp_makeConstraints { make in
            make.centerX.equalTo(view.snp_centerX)
            make.width.equalTo(view).multipliedBy(AuthViewControllerStyleSheet.TextField.Frame.WidthToViewWidthFactor.value)
            make.height.equalTo(view).multipliedBy(AuthViewControllerStyleSheet.TextField.Frame.HeightToViewHeightFactor.value)
            make.top.equalTo(view).offset(view.bounds.height * AuthViewControllerStyleSheet.TextField.Frame.TopToViewTopFactor.value)
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
        
        errorLabel.snp_makeConstraints { make in
            make.centerX.width.equalTo(emailTextField)
            make.bottom.equalTo(emailTextField.snp_top).offset(AuthViewControllerStyleSheet.Label.Frame.BottomToEmailTextFieldToOffset.value)
            make.height.equalTo(AuthViewControllerStyleSheet.Label.Frame.Height.value)
        }

    }
    
}




