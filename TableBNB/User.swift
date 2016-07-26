//
//  User.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/19/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - User

struct User: FBSendable {
    let key:        String
    let username:   String
    let email:      String
    let rating:     Double
}

// MARK: - User Extension

extension User {
    static let Path         = "users/"
    static let NeedsAutoKey = false
    static let FBSubKeys    = ["username", "email", "rating"]
    static let MaxRating    = 5
}

// MARK: - User "createNew" Initializer Extension
// FIXME: - Change FBDict keys from string literals

extension User {
    static func Create(FBDict: FBDictionary?) -> Result<User> {
        guard let FBDict = FBDict else { return .Failure(instantiationError) }
        guard let email = FBDict["email"] as? String, let username = FBDict["username"] as? String, let key = FBDict["key"] as? String,
            let rating = FBDict["rating"] as? Double else { return .Failure(instantiationError) }
        
        return .Success(User(key: key, username: username, email: email, rating: rating))
    }
}

// MARK: - User Equatability

func == (lhs: User, rhs: User) -> Bool {
    return lhs.key == rhs.key && lhs.username == rhs.username && lhs.email == rhs.email && lhs.rating == rhs.rating
}