//
//  Meal.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation

// MARK: - Meal

struct Meal: FBSendable, FBStorageType {
    let key:            String /// each meal's key is equal to the key of the user that created it
    let name:           String
    let pricePerPerson: Double
    let feeds:          Int
//    let chef:           User
}

// MARK: - Meal Extension

extension Meal {
    static let Path         = "meals/"
    static let NeedsAutoKey = false
    static let FBSubKeys    = ["name", "pricePerPerson", "feeds"]
    static let Resource_    = Resource(parse: Meal.Create)
    static var StoragePath  = String.emptyString()
}

// MARK: - Meal "createNew" Initializer Extension
// FIXME: - Change FBDict keys from string literal to Meal.type

extension Meal {
    static func Create(FBDict: FBDictionary?) -> Result<Meal> {
        guard let FBDict = FBDict else { return .Failure(instantiationError) }
        guard let key = FBDict["key"] as? String, let name = FBDict["name"] as? String, let pricePerPerson = FBDict["pricePerPerson"] as? Double,
            let feeds = FBDict["feeds"] as? Int, let storagePath = FBDict["storagePath"] as? String else { return .Failure(instantiationError) }
        
        Meal.StoragePath = storagePath
        return .Success(Meal(key: key, name: name, pricePerPerson: pricePerPerson, feeds: feeds))
    }
}

// MARK: - Meal Equatability

func == (lhs: Meal, rhs: Meal) -> Bool {
    return lhs.key == rhs.key && lhs.name == rhs.name && lhs.pricePerPerson == rhs.pricePerPerson && lhs.feeds == rhs.feeds // && lhs.chef == rhs.chef
}
