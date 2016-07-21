//
//  AuthenticationViewModel.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/20/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import Firebase

protocol AuthenticationViewModelCoordinatorDelegate: class {
    func userHasBeenAuthenticated(user user: User, sender: AuthenticationViewModel)
    func navigateToLoginButtonPressed(sender: AuthenticationViewModel)
}

protocol AuthenticationViewModelViewDelegate: class {
    func anErrorHasOccured(errorMessage: String, sender: AuthenticationViewModel)
    func emailIsValid(sender: AuthenticationViewModel)
    func passwordIsValid(sender: AuthenticationViewModel)
    func setLoginNavigationItem(sender: AuthenticationViewModel)
    func setTitle(title: String, sender: AuthenticationViewModel)
}

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

final class AuthenticationViewModel: AuthenticationViewModelProtocol {
    
    var email: String = "" {
        didSet {
            emailIsValid = validateEmailFormat(email)
            if emailIsValid  { viewDelegate?.emailIsValid(self) }
            if !emailIsValid { viewDelegate?.anErrorHasOccured("Invalid email format", sender: self) } // TODO: Move string literal elsewhere }
        }
    }
    
    var password: String = "" {
        didSet {
            passwordIsValid = validatePasswordFormat(password)
            if passwordIsValid {
                if isSigningUp { viewDelegate?.passwordIsValid(self) }
                if !isSigningUp  { submitAuthenticationRequest() }
            }
            if !passwordIsValid { viewDelegate?.anErrorHasOccured("Invalid password format", sender: self) } // TODO: Move string literal elsewhere
        }
    }
    
    var username: String = "" {
        didSet {
            usernameIsValid = validateUsernameFormat(username)
            if usernameIsValid {
                if isSigningUp  { submitAuthenticationRequest() }
                if !isSigningUp { viewDelegate?.anErrorHasOccured("This isnt possible", sender: self) } // TODO: Move string literal elsewhere }
            }
            if !usernameIsValid { viewDelegate?.anErrorHasOccured("Invalid username format", sender: self) } // TODO: Move string literal elsewhere
        }
    }
    
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
    
    let isSigningUp: Bool
    
    init(isSigningUp: Bool) {
        self.isSigningUp = isSigningUp
    }
    
    func navigateToLoginButtonPressed() {
        coordinatorDelegate?.navigateToLoginButtonPressed(self)
    }
    
    private func submitAuthenticationRequest() {
        guard let model = model where canSubmitAuthenticationRequest else {
            viewDelegate?.anErrorHasOccured("Invalid Authentication Request", sender: self) // TODO: Move string literal elsewhere
            return
        }
        
        if isSigningUp  { model.signUp(email: email, password: password, username: username) { self.handleAuthentication(withResult: $0) } }
        if !isSigningUp { model.login(email: email, password: password) { self.handleAuthentication(withResult: $0) } }
    }
    
    private func handleAuthentication(withResult result: Result<User>) {
        switch result {
        case .Failure(let error): self.viewDelegate?.anErrorHasOccured(error._domain, sender: self)
        case .Success(let user):  self.coordinatorDelegate?.userHasBeenAuthenticated(user: user, sender: self)
        }
    }
    
    private func validateEmailFormat(email: String) -> Bool {
        let arguments = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,32}" // TODO: Move string literal elsewhere
        let format = "SELF MATCHES %@"
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










protocol AuthenticationModelProtocol: class {
    func login(email email: String, password: String, withResult: Result<User> -> Void)
    func signUp(email email: String, password: String, username: String, withResult: Result<User> -> Void)
}

final class AuthenticationModel: AuthenticationModelProtocol {
    
    func login(email email: String, password: String, withResult: Result<User> -> Void) {
        FIRAuth.auth()?.signInWithEmail(email, password: password) { user, error in
            if let error = error {
                print(error.localizedDescription)
                withResult(.Failure(error))
                return
            }
            guard let user = user, let email = user.email, let username = user.displayName else { // TODO: Move string literal elsewhere
                let error = NSError(domain: "TableBNB", code: 1, userInfo: [NSLocalizedDescriptionKey: "Could not create atomic user"])
                withResult(.Failure(error))
                return
            }
            let loggedInUser = User(key: user.uid, username: username, email: email)
            withResult(.Success(loggedInUser))
            return
        }

    }
    
    func signUp(email email: String, password: String, username: String, withResult: Result<User> -> Void) {
        FIRAuth.auth()?.createUserWithEmail(email, password: password) { user, error in
            if let error = error {
                print(error.localizedDescription)
                withResult(.Failure(error))
                return
            }
            guard let user = user else { // TODO: Move string literal elsewhere
                let error = NSError(domain: "TableBNB", code: 1, userInfo: [NSLocalizedDescriptionKey: "Could not create atomic user"])
                withResult(.Failure(error))
                return
            }
            let changeRequest = user.profileChangeRequest()
            changeRequest.displayName = username
            changeRequest.commitChangesWithCompletion { error in
                if let error = error {
                    print(error.localizedDescription)
                    withResult(.Failure(error))
                    return
                }
                let logggedInUser = User(key: user.uid, username: username, email: email)
                logggedInUser.sendToFB { result in
                    switch result {
                    case .Failure(let error): withResult(.Failure(error))
                    case .Success(let user):  withResult(.Success(user))
                    }
                }
                return
            }
        }
    }
}