//
//  FBType.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/19/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import Firebase

// MARK: - FBDictionary

typealias FBDictionary = [String : AnyObject]

// MARK: - FirebaseType Protocol

protocol FBType: Dumpable {
    static var Path: String { get }
}

// MARK: - FirebaseType Protocol Extension

extension FBType { static var RootRef: FIRDatabaseReference { return FIRDatabase.database().reference() } }
