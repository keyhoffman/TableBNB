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

// MARK: - FirebaseObservable Protocol Extension

extension FBObservable {
    func loadChildAdded(withBlock: Result<R> -> Void) {
        observe(withPath: R.Path, withEventType: .ChildAdded) { withBlock($0) }
    }
    
    func loadValue(withKey key: String, withBlock: Result<R> -> Void) {
        observe(withPath: R.Path + key, withEventType: .Value) { withBlock($0) }
    }
    
    private var snapshotError: NSError { // TODO: Move elsewhere
        return NSError(domain: "TableBNB", code: 3, userInfo: [NSLocalizedDescriptionKey: "Could not convert snapshot to type \(Self.self)"])
    }
    
    private func observe(withPath path: String, withEventType event: FIRDataEventType, withBlock: Result<R> -> Void) {
        Self.RootRef.child(path).observeEventType(event, withBlock: { (snapshot: FIRDataSnapshot) in
            guard var FBDict = snapshot.value as? FBDictionary else { // TODO: Is it okay to make FBDict mutable?
                print("Resource loading fail")
                withBlock(.Failure(self.snapshotError))
                return
            }
            FBDict["key"] = snapshot.key
            withBlock(self.parse(FBDict))
            return
        }) { error in
            withBlock(.Failure(error))
            return
        }
    }
}

extension FBObservable where R: FBStorageType {
    private var dataError: NSError {
        return NSError(domain: "TableBNB", code: 3, userInfo: [NSLocalizedDescriptionKey: "Invalid storage loading data for type \(R.self)"])
    }
    
    private var imageError: NSError {
        return NSError(domain: "TableBNB", code: 3, userInfo: [NSLocalizedDescriptionKey: "Could not create image for type \(R.self)"])
    }
    
    func loadImage(withResult: Result<UIImage> -> Void) {
        R.StorageRef.dataWithMaxSize(R.MaxSize) { data, error in
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






