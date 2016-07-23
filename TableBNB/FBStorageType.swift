//
//  FBStorageType.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import Firebase

// MARK: - FBStorageType Protocol

protocol FBStorageType {
    var storagePath: String { get }
}

// MARK: - FBStorageType Protocol Extension

extension FBStorageType {
    private var bucket: String { return "gs://tablebnb.appspot.com" }
    var storageRef: FIRStorageReference { return FIRStorage.storage().referenceForURL(bucket).child(storagePath) }
    var maxSize: Int64 { return 1 * 1024 * 1024 }
}

extension FBSendable where Self: FBStorageType {
    private var dataError: NSError {
        return NSError(domain: "TableBNB", code: 3, userInfo: [NSLocalizedDescriptionKey: "Invalid storage loading data for type \(Self.self)"])
    }
    
    private var imageError: NSError {
        return NSError(domain: "TableBNB", code: 3, userInfo: [NSLocalizedDescriptionKey: "Could not create image for type \(Self.self)"])
    }
    
    func loadImage(withResult: Result<UIImage> -> Void) {
        storageRef.dataWithMaxSize(maxSize) { data, error in
            if let error = error { print("ERROR - \(error)"); withResult(.Failure(error)) }
            guard let data = data else {
                withResult(.Failure(self.dataError))
                return
            }
            guard let image = UIImage(data: data) else {
                withResult(.Failure(self.imageError))
                return
            }
            withResult(.Success(image))
        }
    }
}
