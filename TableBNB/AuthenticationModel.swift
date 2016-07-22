//
//  AuthenticationModel.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import Firebase

// MARK: - AuthenticationModelProtocol

protocol AuthenticationModelProtocol: class {
    func login(email email: String, password: String, withResult: Result<User> -> Void)
    func signUp(email email: String, password: String, username: String, withResult: Result<User> -> Void)
}


// MARK: - AuthenticationModel

final class AuthenticationModel: AuthenticationModelProtocol {
    
    // MARK: AuthenticationModelProtocol Required Methods
    
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