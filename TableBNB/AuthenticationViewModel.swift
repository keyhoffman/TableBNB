//
//  AuthenticationViewModel.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/20/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - AuthenticationViewModelCoordinatorDelegate

protocol AuthenticationViewModelCoordinatorDelegate: class {
    func userHasBeenAuthenticated(user user: User, sender: AuthenticationViewModel)
    func navigateToLoginButtonPressed(sender: AuthenticationViewModel)
}

// MARK: - AuthenticationViewModelViewDelegate

protocol AuthenticationViewModelViewDelegate: class {
    func anErrorHasOccured(errorMessage: String, sender: AuthenticationViewModel)
    func emailIsValid(sender: AuthenticationViewModel)
    func passwordIsValid(sender: AuthenticationViewModel)
    func setLoginNavigationItem(sender: AuthenticationViewModel)
    func setTitle(title: String, sender: AuthenticationViewModel)
}

// MARK: - AuthenticationViewModelProtocol

protocol AuthenticationViewModelProtocol: class, Dumpable {
    var isSigningUp: Bool { get }
    
    var email:    String { get set }
    var password: String { get set }
    var username: String { get set }
    
    var validPasswordCharacterCount: Int { get }
    var validUsernameCharacterCount: Int { get }
    
    var emailIsValid:    Bool { get set }
    var passwordIsValid: Bool { get set }
    var usernameIsValid: Bool { get set }
    
    weak var model: AuthenticationModelProtocol? { get }
    weak var viewDelegate: AuthenticationViewModelViewDelegate? { get set }
    weak var coordinatorDelegate: AuthenticationViewModelCoordinatorDelegate? { get }
    
    func navigateToLoginButtonPressed()
    
    init(isSigningUp: Bool)
}

// MARK: - AuthenticationViewModel

final class AuthenticationViewModel: AuthenticationViewModelProtocol {
    
    // MARK: - User Input Declarations
    
    var email: String = String.emptyString() {
        didSet {
            emailIsValid = validateEmailFormat(email)
            if emailIsValid  { viewDelegate?.emailIsValid(self) }
            if !emailIsValid { viewDelegate?.anErrorHasOccured("Invalid email format", sender: self) } // TODO: Move string literal elsewhere }
        }
    }
    
    var password: String = String.emptyString() {
        didSet {
            passwordIsValid = validatePasswordFormat(password)
            if passwordIsValid {
                if isSigningUp  { viewDelegate?.passwordIsValid(self) }
                if !isSigningUp { submitAuthenticationRequest() }
            }
            if !passwordIsValid { viewDelegate?.anErrorHasOccured("Invalid password format", sender: self) } // TODO: Move string literal elsewhere
        }
    }
    
    var username: String = String.emptyString() {
        didSet {
            usernameIsValid = validateUsernameFormat(username)
            if usernameIsValid {
                if isSigningUp  { submitAuthenticationRequest() }
                if !isSigningUp { viewDelegate?.anErrorHasOccured("This isnt possible", sender: self) } // TODO: Move string literal elsewhere }
            }
            if !usernameIsValid { viewDelegate?.anErrorHasOccured("Invalid username format", sender: self) } // TODO: Move string literal elsewhere
        }
    }
    
    // MARK: - User Input Validation Declarations
    
    let validPasswordCharacterCount = AuthViewModelStyleSheet.ValidPasswordCharacterCount
    let validUsernameCharacterCount = AuthViewModelStyleSheet.ValidUsernameCharacterCount
    
    var emailIsValid    = false
    var passwordIsValid = false
    var usernameIsValid = false
    
    
    private var canSubmitAuthenticationRequest: Bool {
        switch isSigningUp {
        case false: return emailIsValid && passwordIsValid
        case true:  return emailIsValid && passwordIsValid && usernameIsValid
        }
    }
    
    // MARK: - Delegate and Model Declarations
    
    weak var model: AuthenticationModelProtocol?
    weak var coordinatorDelegate: AuthenticationViewModelCoordinatorDelegate?
    weak var viewDelegate: AuthenticationViewModelViewDelegate? {
        didSet {
            switch isSigningUp {
            case false: viewDelegate?.setTitle(AuthViewControllerStyleSheet.LoginTitle, sender: self)
            case true:  viewDelegate?.setTitle(AuthViewControllerStyleSheet.SignUpTitle, sender: self)
                        viewDelegate?.setLoginNavigationItem(self)
            }
        }
    }
    
    // MARK: - Authentication Action Declaration
    
    let isSigningUp: Bool
    
    init(isSigningUp: Bool) {
        self.isSigningUp = isSigningUp
    }
    
    // MARK: - Navigation Methods
    
    func navigateToLoginButtonPressed() {
        coordinatorDelegate?.navigateToLoginButtonPressed(self)
    }
    
    // MARK: - Authentication Submission Methods
    
    private func submitAuthenticationRequest() {
        guard let model = model where canSubmitAuthenticationRequest else {
            viewDelegate?.anErrorHasOccured("Invalid Authentication Request", sender: self) // TODO: Move string literal elsewhere
            return
        }
        
        if isSigningUp  { model.signUp(email: email, password: password, username: username) { self.handleAuthentication(withResult: $0) } }
        if !isSigningUp { model.login(email: email, password: password)                      { self.handleAuthentication(withResult: $0) } }
    }
    
    private func handleAuthentication(withResult result: Result<User>) {
        switch result {
        case .Failure(let error): self.viewDelegate?.anErrorHasOccured(error._domain, sender: self)
        case .Success(let user):  self.coordinatorDelegate?.userHasBeenAuthenticated(user: user, sender: self)
        }
    }
    
    // MARK: - User Input Validation Methods
    
    private func validateEmailFormat(email: String) -> Bool {
        let format    = AuthViewModelStyleSheet.ValidEmailPredicateFormat
        let arguments = AuthViewModelStyleSheet.ValidEmailPredicateArguments
        return NSPredicate(format: format, arguments).evaluateWithObject(email)
    }
    
    private func validatePasswordFormat(password: String) -> Bool {
        let trimmedString = password.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
        return trimmedString.characters.count > validPasswordCharacterCount
    }
    
    private func validateUsernameFormat(username: String) -> Bool {
        return username.characters.count > validUsernameCharacterCount
    }
    
}










