//
//  FBStorageType.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import Firebase

protocol FBStorageType {
    static var StoragePath: String { get set }
}

extension FBStorageType {
    private static var Bucket: String { return "gs://tablebnb.appspot.com" }
    static var StorageRef: FIRStorageReference { return FIRStorage.storage().referenceForURL(Bucket).child(StoragePath) }
    static var MaxSize: Int64 { return 1 * 1024 * 1024 }
}