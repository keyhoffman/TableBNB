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
    func userHasBeenAuthenticated(user user: User)
    func userHasBeenLoggedOut(loggedOutUser user: User)
}

// MARK: - AuthenticationChecker Protocol

protocol AuthenticationChecker {}

// MARK: - AuthenticationChecker Protocol Extension

extension AuthenticationChecker {
    func checkCurrentUser() -> User? {
        let auth = FIRAuth.auth()
        guard let key = auth?.currentUser?.uid, email = auth?.currentUser?.email, username = auth?.currentUser?.displayName  else { return nil }
        return User(key: key, username: username, email: email, rating: 0)
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
    
    // MARK: - ViewModel Declarations
    
    private let signUpViewModel: AuthenticationViewModelType
    private let loginViewModel:  AuthenticationViewModelType
    
    // MARK: - Model Declarations
    
    private let signUpModel: AuthenticationModelType
    private let loginModel:  AuthenticationModelType
    
    // MARK: - AuthenticationCoordinator Initializer
    
    init(window: UIWindow) {
        self.window = window
        
        signUpViewController = AuthenticationViewController()
        loginViewController  = AuthenticationViewController()
        
        signUpViewModel = AuthenticationViewModel(isSigningUp: true)
        loginViewModel  = AuthenticationViewModel(isSigningUp: false)
        
        signUpModel = AuthenticationModel()
        loginModel  = AuthenticationModel()
        
        signUpViewController.viewModel = signUpViewModel
        loginViewController.viewModel  = loginViewModel
        
        signUpViewModel.model = signUpModel
        loginViewModel.model  = loginModel
        
        signUpViewModel.coordinatorDelegate = self
        loginViewModel.coordinatorDelegate  = self
    }

    
    // MARK: - SubCoordinator Required Methods
    
    func start() {
        if let user = checkCurrentUser() { coordinatorDelegate?.userHasBeenAuthenticated(user: user) }
        else {
            window.rootViewController = rootViewController
            window.makeKeyAndVisible()
            rootViewController.pushViewController(signUpViewController, animated: false)
        }
    }
    
    // MARK: - AuthenticationViewModelCoordinatorDelegate Required Methods
    
    func userHasBeenAuthenticated(user user: User) {
        coordinatorDelegate?.userHasBeenAuthenticated(user: user)
    }
    
    func navigateToLoginButtonPressed() {
        rootViewController.pushViewController(loginViewController, animated: true)
    }
    
}










