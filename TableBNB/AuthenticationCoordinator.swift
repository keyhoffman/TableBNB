//
//  AuthenticationCoordinator.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/19/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import UIKit
import Firebase

// MARK: - AuthenticationCoordinatorDelegate Protocol

protocol AuthenticationCoordinatorDelegate: class {
    func userHasBeenAuthenticated(authenticatedUser user: User, sender: AuthenticationCoordinator)
    func userHasBeenLoggedOut(loggedOutUser user: User, sender: AuthenticationCoordinator)
}

// MARK: - AuthenticationChecker Protocol

protocol AuthenticationChecker {
    func checkCurrentUser() -> User?
}

// MARK: - AuthenticationChecker Protocol Extension

extension AuthenticationChecker {
    func checkCurrentUser() -> User? {
        let auth = FIRAuth.auth()
        guard let key = auth?.currentUser?.uid, email = auth?.currentUser?.email, username = auth?.currentUser?.displayName  else { return nil }
        return User(key: key, username: username, email: email)
    }
}

// MARK: - AuthenticationCoordinator

final class AuthenticationCoordinator: SubCoordinator, AuthenticationChecker, AuthenticationViewModelCoordinatorDelegate {
    
    // MARK: - AuthenticationCoordinatorDelegate Declaration
    
    weak var coordinatorDelegate: AuthenticationCoordinatorDelegate?
    
    // MARK: - Root Property Declarations
    
    private let window: UIWindow
    private let rootViewController = UINavigationController()
    
    // MARK: - ViewController Declarations
    
    private let signUpViewController: AuthenticationViewController
    private let loginViewController:  AuthenticationViewController
    
    private let signUpViewModel = AuthenticationViewModel(isSigningUp: true)
    private let loginViewModel  = AuthenticationViewModel(isSigningUp: false)
    
    private let signUpModel = AuthenticationModel()
    private var loginModel  = AuthenticationModel()
    
    // MARK: - AuthenticationCoordinator Initializer
    
    init(window: UIWindow) {
        self.window = window
        
        signUpViewController = AuthenticationViewController()
        loginViewController  = AuthenticationViewController()
        
        signUpViewController.viewModel = signUpViewModel
        loginViewController.viewModel  = loginViewModel
        
        signUpViewModel.model = signUpModel
        loginViewModel.model  = loginModel
        
        signUpViewModel.coordinatorDelegate = self
        loginViewModel.coordinatorDelegate  = self
    }

    
    // MARK: SubCoordinator Required Methods
    
    func start() {
        if let user = checkCurrentUser() { coordinatorDelegate?.userHasBeenAuthenticated(authenticatedUser: user, sender: self) }
        else {
            window.rootViewController = rootViewController
            window.makeKeyAndVisible()
            rootViewController.pushViewController(signUpViewController, animated: false)
        }
    }
    
    func userHasBeenAuthenticated(user user: User, sender: AuthenticationViewModel) {
        user.dump_(withContext: "userHasBeenAuthenticated")
    }
    
    func navigateToLoginButtonPressed(sender: AuthenticationViewModel) {
        rootViewController.pushViewController(loginViewController, animated: true)
    }
    
}










