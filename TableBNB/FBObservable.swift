//
//  FBObservable.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import Firebase

// MARK: - FirebaseObservable Protocol

protocol FBObservable: FBType {
    associatedtype R: FBSendable
    var parse: FBDictionary? -> Result<R> { get }
}
