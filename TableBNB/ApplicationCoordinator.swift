//
//  ApplicationCoordinator.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/19/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import UIKit
import Firebase // TODO: Delete!

final class ApplicationCoordinator: Coordinator, AuthenticationCoordinatorDelegate {
    
    // MARK: - UIWindow
    
    private let window: UIWindow
    
    // MARK: - Sub-Coordinator Declarations
    
    private let authenticationCoordinator: AuthenticationCoordinator
//    private let tabBarCoordinator:         TabBarCoordinator
    
    // MARK: - ApplicationCoordinator Initializer
    
    init(window: UIWindow) {
        self.window = window
        
        authenticationCoordinator = AuthenticationCoordinator(window: self.window)
//        tabBarCoordinator         = TabBarCoordinator(window: self.window)
//        
        authenticationCoordinator.coordinatorDelegate = self
//        tabBarCoordinator.coordinatorDelegate         = self
    }
    
    // MARK: - Coordinator Required Methods 
    
    func start() {
        try! FIRAuth.auth()?.signOut() // TODO: Delete!
        authenticationCoordinator.start()
    }
    
    // MARK: - AuthenticationCoordinatorDelegate Required Methods
    
    func userHasBeenAuthenticated(authenticatedUser user: User, sender: AuthenticationCoordinator) {
        user.dumpWithContext("ApplicationCoordinator")
    }
    
    func userHasBeenLoggedOut(loggedOutUser user: User, sender: AuthenticationCoordinator) {
        user.dumpWithContext("ApplicationCoordinator ---- WTFFFFF")
    }
}