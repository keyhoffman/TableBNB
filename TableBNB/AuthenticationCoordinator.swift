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

// MARK: - Authenticator Protocol

protocol Authenticator {
    func checkCurrentUser() -> User?
}

extension Authenticator {
    func checkCurrentUser() -> User? {
        let auth = FIRAuth.auth()
        guard let key = auth?.currentUser?.uid, email = auth?.currentUser?.email, username = auth?.currentUser?.displayName  else { return nil }
        return User(key: key, username: username, email: email)
    }
}

final class AuthenticationCoordinator: SubCoordinator, Authenticator, AuthenticationViewControllerDelegate {
    
    // MARK: - AuthenticationCoordinatorDelegate Declaration
    
    weak var coordinatorDelegate: AuthenticationCoordinatorDelegate?
    
    // MARK: - Root Property Declarations
    
    private let window: UIWindow
    private let rootViewController = UINavigationController()
    
    // MARK: - ViewController Declarations
    
    private let signUpViewController:  AuthenticationViewController
    private let loginViewController:   AuthenticationViewController
    
    // MARK: - AuthenticationCoordinator Initializer
    
    init(window: UIWindow) {
        self.window = window
        signUpViewController = AuthenticationViewController(isSigningUp: true)
        loginViewController  = AuthenticationViewController(isSigningUp: false)
        

        signUpViewController.delegate  = self
        loginViewController.delegate   = self
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
    
    func navigateToLoginButtonPressed(sender: AuthenticationViewController) {
        rootViewController.pushViewController(loginViewController, animated: true)
    }
}

// MARK: - AuthenticationViewControllerDelegate Methods

extension Authenticator where Self: AuthenticationCoordinator, Self: AuthenticationViewControllerDelegate {
    func login(email email: String?, password: String?, sender: AuthenticationViewController) {
        guard let email = email, let password = password else {
            print("Login Error")
            return
        }
        FIRAuth.auth()?.signInWithEmail(email, password: password) { user, error in
            if let error = error {
                print(error.localizedDescription)
                print("Login Error")
                return
            }
            guard let user = user, let email = user.email, let username = user.displayName else {
                print("Login Error")
                return
            }
            let loggedInUser = User(key: user.uid, username: username, email: email)
            self.coordinatorDelegate?.userHasBeenAuthenticated(authenticatedUser: loggedInUser, sender: self)
            return
        }
    }
    
    func signUp(email email: String?, password: String?, username: String?, sender: AuthenticationViewController) {
        guard let email = email, let password = password, let username = username else {
            print("Sign Up Error")
            return
        }
        FIRAuth.auth()?.createUserWithEmail(email, password: password) { user, error in
            if let error = error {
                print(error.localizedDescription)
                print("Sign Up Error")
                return
            }
            guard let user = user else {
                print("Sign Up Error")
                return
            }
            let changeRequest = user.profileChangeRequest()
            changeRequest.displayName = username
            changeRequest.commitChangesWithCompletion { error in
                if let error = error {
                    print(error.localizedDescription)
                    print("Sign Up Error")
                    return
                }
                let logggedInUser = User(key: user.uid, username: username, email: email)
                logggedInUser.sendToFB { result in
                    switch result {
                    case .Failure(let err):  print(err._domain)
                    case .Success(let user): self.coordinatorDelegate?.userHasBeenAuthenticated(authenticatedUser: user, sender: self)
                    }
                }
                return
            }
        }
    }
}










